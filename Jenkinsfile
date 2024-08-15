@Library('releng-pipeline@main') _

pipeline {
  agent {
    kubernetes {
      yaml loadOverridableResource(
        libraryResource: 'org/eclipsefdn/container/agent.yml'
      )
    }
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    disableConcurrentBuilds()
    timeout(time: 90, unit: 'MINUTES')
  }

  environment {
    HOME = '${env.WORKSPACE}'
    CREDENTIALS_ID = 'e93ba8f9-59fc-4fe4-a9a7-9a8bd60c17d9'
    BUILD_DIR = './target'
  }

  triggers {
    cron('H H * * */3')
  }

  stages {
    stage('Build Agents') {
      steps {
        container('containertools') {
          sh '''
            mkdir -p "${BUILD_DIR}"
            jsonnet agents.jsonnet > "${BUILD_DIR}/agents.json"
          '''
        }
      }
    }
    stage('Build Images') {
      steps {
        script {
          def agentIds = sh(script: "jq -r '. | keys[]' ${env.BUILD_DIR}/agents.json", returnStdout: true).trim().split('\n')
          def stages = [:]
          agentIds.each { id ->
              stages.putAll(buildAgent(id))
          }
          stash(name: 'workspace', includes: '**')
          parallel(stages)
        }
      }
    }
  }

  post {
    failure {
      mail to: 'releng-team@eclipse-foundation.org',
        subject: "[CBI] Build Failure ${currentBuild.fullDisplayName}",
        mimeType: 'text/html',
        body: "Project: ${env.JOB_NAME}<br/>Build Number: ${env.BUILD_NUMBER}<br/>Build URL: ${env.BUILD_URL}<br/>Console: ${env.BUILD_URL}/console"
    }
    fixed {
      mail to: 'releng-team@eclipse-foundation.org',
        subject: "[CBI] Back to normal ${currentBuild.fullDisplayName}",
        mimeType: 'text/html',
        body: "Project: ${env.JOB_NAME}<br/>Build Number: ${env.BUILD_NUMBER}<br/>Build URL: ${env.BUILD_URL}<br/>Console: ${env.BUILD_URL}/console"
    }
    cleanup {
      deleteDir() /* clean up workspace */
    }
  }
}

def buildAgent(id) {
    String configDir = "${env.BUILD_DIR}/${id}"
    String config = "${configDir}/agent.json"
    String AGENTS_JSON="${env.BUILD_DIR}/agents.json"

    def stages = [:]

    println "Building jiro-agent spec '${id}'"

    sh "mkdir -p ${configDir}"
    sh "jq -r '.[\"${id}\"]' ${AGENTS_JSON} > ${config}"
    sh "jq -r '.spec.docker.dockerfile' ${config} > ${configDir}/Dockerfile"

    String name = sh(script: "jq -r '.spec.docker.registry' ${config}", returnStdout: true).trim() +
                "/" + sh(script: "jq -r '.spec.docker.repository' ${config}", returnStdout: true).trim() +
                "/" + sh(script: "jq -r '.spec.docker.image' ${config}", returnStdout: true).trim()
    String version = sh(script: "jq -r '.spec.docker.tag' ${config}", returnStdout: true).trim()
    String context = sh(script: "jq -r '.spec.docker.context' ${config}", returnStdout: true).trim()
    String build_args = sh(script: "jq -r '.spec.docker.build_args' ${config}", returnStdout: true).trim()

    stages["${name}:${version}"] = {
      buildImage(name, version, "", "${configDir}/Dockerfile", context, build_args)
    }

    def result = sh(script: "jq -r '.variants | keys[]' ${config}", returnStdout: true).trim()
    result.split('\n').each { variant ->
      stages.putAll(buildAgentVariant(id, variant, config))
    }
    return stages
}

def buildAgentVariant(id, variant, agentConfig) {
    def configDir = "${env.BUILD_DIR}/${id}/${variant}"
    def config = "${configDir}/variant.json"

    def stages = [:]

    println "Building jiro-agent '${id}' - variant ${variant}"

    sh "mkdir -p ${configDir}"
    sh "jq -r '.variants[\"${variant}\"]' ${agentConfig} > ${config}"
    sh "jq -r '.docker.dockerfile' ${config} > ${configDir}/Dockerfile"

    String name = sh(script: "jq -r '.spec.docker.registry' ${agentConfig}", returnStdout: true).trim() +
                "/" + sh(script: "jq -r '.spec.docker.repository' ${agentConfig}", returnStdout: true).trim() +
                "/" + sh(script: "jq -r '.spec.docker.image' ${agentConfig}", returnStdout: true).trim()
    String version = sh(script: "jq -r '.docker.tag' ${config}", returnStdout: true).trim()

    String aliases = sh(script: "jq -r '.docker.aliases | join(\",\")' ${config}", returnStdout: true).trim()
    String build_args = sh(script: "jq -r '.spec.docker.build_args' ${config}", returnStdout: true).trim()

    stages["${name}:${version}"] = {
      buildImage(name, version, aliases, "${configDir}/Dockerfile", "${configDir}", build_args)
    }
    return stages
}

def buildImage(String name, String version, String aliases = "", String dockerfile, String context, Map<String, String> buildArgs = [:], boolean latest = false) {
  String distroName = name + ':' + version + ' (' + aliases + ')'
  println '############ buildImage ' + distroName + ' ############'
  def containerBuildArgs = buildArgs.collect { k, v -> '--opt build-arg:' + k + '=' + v }.join(' ')

  podTemplate(yaml: loadOverridableResource(libraryResource: 'org/eclipsefdn/container/agent.yml')) {
    node(POD_LABEL) {
      container('containertools') {
        unstash('workspace')
        containerBuild(
          credentialsId: env.CREDENTIALS_ID,
          name: name,
          version: version,
          aliases: aliases,
          dockerfile: dockerfile,
          context: context,
          buildArgs: containerBuildArgs,
          push: env.GIT_BRANCH == 'master',
          latest: latest
        )
      }
    }
  }
}
