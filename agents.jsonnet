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
        labels: ["basic"],
        mode: "NORMAL", # utilize agent as much as possible
        docker+: {
          raw_dockerfile:: importstr "basic/Dockerfile",
        },
      },
    },
    default + {
      spec+: {
        name: "basic-ubuntu",
        labels: ["basic-ubuntu"],
        docker+: {
          raw_dockerfile:: importstr "basic-ubuntu/Dockerfile",
        },
      },
    },
    //centos-7 docker image will no longer be build
    default + {
      spec+: {
        name: "centos-7",
        labels: ["migration", "jipp-migration", "centos-7" ],
        docker+: {
          raw_dockerfile:: importstr "dummy-dockerfile",
        },
      },
    },
    //centos-8 docker image will no longer be build
    default + {
      spec+: {
        name: "centos-8",
        labels: ["centos-latest", "centos-8" ],
        docker+: {
          raw_dockerfile:: importstr "dummy-dockerfile",
        },
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
      },
    },
    default + {
      spec+: {
        name: "ubuntu-2404",
        labels: ["ubuntu-latest", "ubuntu-2404"],
        docker+: {
          raw_dockerfile:: importstr "ubuntu/Dockerfile",
          build_args: "['FROM_TAG': '24.04']",
          context: "ubuntu",
        },
      },
    },
  ]
}
