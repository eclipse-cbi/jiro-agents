/******************************************************************************
 * Copyright (c) 2020 Eclipse Foundation and others.
 * This program and the accompanying materials are made available
 * under the terms of the Eclipse Public License 2.0
 * which is available at http://www.eclipse.org/legal/epl-v20.html,
 * or the MIT License which is available at https://opensource.org/licenses/MIT.
 * SPDX-License-Identifier: EPL-2.0 OR MIT
 *****************************************************************************/
{
  name: error "Provide agent name",
  labels: [],
  # Default is 'exclusive'. 
  # 'normal' means "utilize agent as much as possible"
  # 'exclusive' means "leave for tied jobs only". 
  # See https://javadoc.jenkins.io/hudson/model/Node.Mode.html
  mode: "exclusive", 
  username: "jenkins",
  home: "/home/%s" % self.username,
  agentWorkdir: self.home + "/agent",
  startupScript: "/usr/local/bin/jenkins-agent",

  docker: {
    registry: "docker.io",
    repository: "eclipsecbijenkins",
    image: $.name,
    tag: "base",
    raw_dockerfile:: error "Provide an dockerfile",
    dockerfile: self.raw_dockerfile % $,
  },

  env: {
    JAVA_OPTS: [""],
      # org.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true to allow git client to ssh clone to use passphrase protected keys
    JNLP_PROTOCOL_OPTS: [
      "-XshowSettings:vm", 
      "-Xmx256m", 
      "-Djdk.nativeCrypto=false", 
      "-Dsun.zip.disableMemoryMapping=true", 
      "-Dorg.jenkinsci.remoting.engine.JnlpProtocol3.disabled=true", 
      "-Dorg.jenkinsci.plugins.gitclient.CliGitAPIImpl.useSETSID=true"
    ],
    JAVA_TOOL_OPTIONS: [],
    OPENJ9_JAVA_OPTIONS: [
      "-XX:+IgnoreUnrecognizedVMOptions",
      "-XX:+IdleTuningCompactOnIdle",
      "-XX:+IdleTuningGcOnIdle",
      "-XX:MaxRAMPercentage=64",
    ],
    IBM_JAVA_OPTIONS: [
      "-XX:+IgnoreUnrecognizedVMOptions",
      "-XX:+IdleTuningCompactOnIdle",
      "-XX:+IdleTuningGcOnIdle",
      "-XX:MaxRAMPercentage=64"
    ],
    _JAVA_OPTIONS: [],
  },

  remoting_dockerfile:: importstr "remoting/Dockerfile",
  variants: {
    [variant.remoting.version]: variant for variant in [
      {
        remoting: remoting,
        docker: $.docker + {
          tag: remoting.version,
          dockerfile: $.remoting_dockerfile % (
            $ + {
              from: "%s/%s/%s:%s" % [$.docker.registry, $.docker.repository, $.docker.image, $.docker.tag],
              remotingJar: remoting.jar,
              remotingJarUrl: remoting.url,
              startupScriptUrl: remoting.startupScript.url,
            }
          ),
        },
      } for remoting in (import "remoting/remoting.jsonnet").releases
    ]
  },
}