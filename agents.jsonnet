#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
local default = import "default.libsonnet";
{
  [agent.spec.name]: agent for agent in [
    default + {
      spec+: {
        name: "basic",
        labels: ["basic", "basic-ubuntu"],
        mode: "NORMAL", # utilize agent as much as possible
        docker+: {
          image: "jiro-agent-basic-ubuntu",
          raw_dockerfile:: importstr "basic-ubuntu/Dockerfile",
        },
        remoting_dockerfile: importstr "remoting-ubuntu/Dockerfile",
      },
    },
    default + {
      spec+: {
        name: "ubuntu-2204",
        labels: ["ubuntu-2204"],
        docker+: {
          raw_dockerfile:: importstr "ubuntu/Dockerfile",
          build_args: "['FROM_TAG': '22.04']",
          context: "ubuntu",
        },
        remoting_dockerfile: importstr "remoting-ubuntu/Dockerfile",
      },
    },
    default + {
      spec+: {
        name: "ubuntu-2404",
        //added transitional labels to avoid broken builds
        labels: ["ubuntu-latest", "ubuntu-2404", "migration", "jipp-migration", "centos-7", "centos-8", "centos-latest"],
        docker+: {
          raw_dockerfile:: importstr "ubuntu/Dockerfile",
          build_args: "['FROM_TAG': '24.04']",
          context: "ubuntu",
        },
        remoting_dockerfile: importstr "remoting-ubuntu/Dockerfile",
      },
    },
  ]
}
