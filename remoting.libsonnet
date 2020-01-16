{
  // releasesMap: {
  //   [x.remoting.version]: x for x in $.releases
  // } + {
  //   latest: self["3.36"],
  // },
  
  // one can customize docker info, e.g. image name like
  // {local a=self, name: "awesome-agent", docker:{image:{name: a.name+"-image-name-suffix"},},},
  providedAgents: [
    {name: "basic-agent", },
    {name: "jipp-migration-agent", labels: ["migration", "jipp-migration", ], },
    {name: "ui-test-agent", labels: ["ui-test", "ui-tests", ], },
  ],

  # See https://github.com/jenkinsci/docker-jnlp-slave/releases for the jnlpAgentScript.version
  releases: [
    {
      remoting: {
        version: "3.36",
        jar: $.remoting.jar,
      },
      jnlpAgentScript: {
        version: "3.36-2",
        name: $.jnlpAgentScript.name,
      },
      home: $.home,
      agentWorkdir: $.agentWorkdir,
      env: $.env,
    },
    {
      remoting: {
        version: "3.35",
        jar: $.remoting.jar,
      },
      jnlpAgentScript: {
        version: "3.35-5",
        name: $.jnlpAgentScript.name,
      },
      home: $.home,
      agentWorkdir: $.agentWorkdir,
      env: $.env,
    },
    {
      remoting: {
        version: "3.29",
        jar: "/usr/share/jenkins/slave.jar",
      },
      jnlpAgentScript: {
        version: "3.29-1",
        name: "jenkins-slave",
      },
      home: $.home,
      agentWorkdir: $.agentWorkdir,
      env: $.env,
    },
    {
      remoting: {
        version: "3.27",
        jar: "/usr/share/jenkins/slave.jar",
      },
      jnlpAgentScript: {
        version: "3.27-1",
        name: "jenkins-slave",
      },
      home: $.home,
      agentWorkdir: $.agentWorkdir,
      env: $.env,
    },
  ],
  
  agents: {
    [agent.name]: {
      versions: {
        [remotingRelease.remoting.version]: {
          labels: if std.objectHas(agent, "labels") then agent.labels else [],
          docker: {
            repository: "eclipsecbijenkins",
            image: {
              name: agent.name,
              tag: remotingRelease.remoting.version,
            },
          },
        } + remotingRelease for remotingRelease in $.releases
      },
    } + {
      folder: if std.objectHas(agent, "folder") then agent.folder else agent.name
    } for agent in $.providedAgents
  },

  home: "/home/jenkins",
  agentWorkdir: self.home + "/agent",
  # this must match https://github.com/jenkinsci/docker-jnlp-slave/blob/master/jenkins-agent 
  # (java -jar <remotingJar>) for a given version
  remoting: {
    jar: "/usr/share/jenkins/agent.jar",
  },
  jnlpAgentScript: {
    name: "jenkins-agent",
  },
  env: [
    {
      name: "JAVA_OPTS",
      value: ""
    },
    {
      name: "JNLP_PROTOCOL_OPTS",
      # org.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true to allow git client to ssh clone to use passphrase protected keys
      value: "-XshowSettings:vm -Xmx256m -Djdk.nativeCrypto=false -Dsun.zip.disableMemoryMapping=true -Dorg.jenkinsci.remoting.engine.JnlpProtocol3.disabled=true -Dorg.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true"
    },
    {
      name: "JAVA_TOOL_OPTIONS",
      value: "-XX:+IgnoreUnrecognizedVMOptions -XX:+UseContainerSupport -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
    },
    {
      name: "OPENJ9_JAVA_OPTIONS",
      value: "-XX:+IgnoreUnrecognizedVMOptions -XX:+UseContainerSupport -XX:+IdleTuningCompactOnIdle -XX:+IdleTuningGcOnIdle -XX:MaxRAMPercentage=64"
    },
    {
      name: "IBM_JAVA_OPTIONS",
      value: "-XX:+IgnoreUnrecognizedVMOptions -XX:+UseContainerSupport -XX:+IdleTuningCompactOnIdle -XX:+IdleTuningGcOnIdle -XX:MaxRAMPercentage=64"
    },
    {
      name: "_JAVA_OPTIONS",
      value: "-XX:MaxRAMPercentage=64.0"
    },
  ],
}