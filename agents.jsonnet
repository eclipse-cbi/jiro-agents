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
        mode: "NORMAL", # utilize agent as much as possible
        docker+: {
          raw_dockerfile: importstr "basic/Dockerfile",
        },
      },
    },
    default + {
      spec+: {
        name: "centos-7",
        labels: ["migration", "jipp-migration", "centos", "centos-7" ],
        docker+: {
          raw_dockerfile: importstr "centos-7/Dockerfile",
        },
      }
    },
    default + {
      spec+: {
        name: "ui-tests-agent",
        labels: ["ui-test", "ui-tests", ],
        docker+: {
          raw_dockerfile: importstr "ui-tests-agent/Dockerfile",
        },
      },
    },
  ]
}