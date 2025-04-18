/******************************************************************************
 * Copyright (c) 2020 Eclipse Foundation and others.
 * This program and the accompanying materials are made available
 * under the terms of the Eclipse Public License 2.0
 * which is available at http://www.eclipse.org/legal/epl-v20.html,
 * or the MIT License which is available at https://opensource.org/licenses/MIT.
 * SPDX-License-Identifier: EPL-2.0 OR MIT
 *****************************************************************************/
{
  spec: {
    local thisSpec = self,
    name: error "Provide agent name",
    labels: [],
    # Default is 'EXCLUSIVE'. 
    # 'NORMAL' means "utilize agent as much as possible"
    # 'EXCLUSIVE' means "leave for tied jobs only". 
    # See https://javadoc.jenkins.io/hudson/model/Node.Mode.html
    mode: "EXCLUSIVE", 
    username: "jenkins",
    home: "/home/%s" % self.username,
    agentWorkdir: self.home + "/jenkins-agent",
    startupScript: "/usr/local/bin/jenkins-agent",
    maxHeap: "256m",

    docker: {
      registry: "docker.io",
      repository: "eclipsecbi",
      image: "jiro-agent-%s" % thisSpec.name,
      tag: "spec",
      context: thisSpec.name,
      raw_dockerfile:: error "Provide an dockerfile",
      dockerfile: self.raw_dockerfile % thisSpec,
    },

    env: {
      JENKINS_REMOTING_JAVA_OPTS: [
        "-showversion",
        "-XshowSettings:vm", 
        "-Xmx%s" % thisSpec.maxHeap, 
        "-Dorg.jenkinsci.remoting.engine.JnlpProtocol3.disabled=true", 
        # org.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true to allow git client to ssh clone to use passphrase protected keys
        # https://github.com/jenkinsci/git-client-plugin/blob/master/src/main/java/org/jenkinsci/plugins/gitclient/CliGitAPIImpl.java#L100
        "-Dorg.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true"
      ],
      OPENJ9_JAVA_OPTIONS: [
        "-XX:+IgnoreUnrecognizedVMOptions",
        "-XX:+IdleTuningCompactOnIdle",
        "-XX:+IdleTuningGcOnIdle",
      ],
      # Some parent images (from adoptopenjdk) define such an env. We disable them.
      JAVA_TOOL_OPTIONS: [],
      _JAVA_OPTIONS: [],
    },
    
    remoting_dockerfile:: importstr "remoting/Dockerfile",
  },

  local remotings = import "remoting/remoting.json",

  variants: {
    [variant.remoting.version]: variant for variant in [
      {
        remoting: {
          version: releases.remotingVersion,
          assert std.length(self.version) != 0: "Must specify remoting version",
          # <jar> must match the path declared in the startupScript 
          # Look at the "-cp <jar>" for a given version
          jar: "/usr/share/jenkins/agent.jar",
          url: "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/%s/remoting-%s.jar" % [ self.version, self.version, ],
          startupScript: {
            name: "jenkins-agent",
            version: releases.startupScriptVersion,
            assert std.length(self.version) != 0: "Must specify startupScript version",
            url: "https://github.com/jenkinsci/docker-agent/raw/%s/%s" % [ self.version, self.name, ],
          }
        },
        local this = self, # workaround to make objects available in nested objects below
        docker: $.spec.docker + {
          tag: "remoting-%s" % releases.remotingVersion,
          aliases: if remotings.latest == releases.remotingVersion then [
            "%s/%s/%s:%s" % [self.registry, self.repository, self.image, "latest"]
          ] else [],
          dockerfile: $.spec.remoting_dockerfile % (
            $.spec + {
              from: "%s/%s/%s:%s" % [$.spec.docker.registry, $.spec.docker.repository, $.spec.docker.image, $.spec.docker.tag],
              remotingJar: this.remoting.jar,
              remotingJarUrl: this.remoting.url,
              startupScriptUrl: this.remoting.startupScript.url,
            }
          ),
        },
      } for releases in remotings.releases
    ]
  },

  addAliases(superVariants, names):: {
    [variant]+: superVariants[variant] + {
      docker+: {
        aliases+: [ 
          name % superVariants[variant].remoting.version for name in names
        ] + if remotings.latest == superVariants[variant].remoting.version then [ 
          name % "latest" for name in names 
        ] else [],
      },
    }, for variant in std.objectFields(superVariants)
  },
}