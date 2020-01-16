pipeline {

  agent {
    label 'docker-build'
  }

  options { 
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  environment {
    REPO_NAME = "eclipsecbi"
    DOCKERTOOLS_PATH = sh(script: "printf ${env.WORKSPACE}/.dockertools", returnStdout: true)
  }

  triggers {
    cron('H H * * */3')
  }

  stages {
    stage('Build and push agent images') {
      steps {
        withDockerRegistry([credentialsId: 'e93ba8f9-59fc-4fe4-a9a7-9a8bd60c17d9', url: 'https://index.docker.io/v1/']) {
          sh 'make all'
        }
      }
    }
  }

  post {
    always {
      deleteDir() /* clean up workspace */
    }
  }
}
