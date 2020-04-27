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
  [agent.name]: agent for agent in [
    default + {
      name: "basic-agent",
      mode: "normal", # utilize agent as much as possible
      docker+: {
        raw_dockerfile: importstr "basic-agent/Dockerfile",
      },
    },
    default + {
      name: "jipp-migration-agent",
      labels: ["migration", "jipp-migration", ],
      docker+: {
        raw_dockerfile: importstr "jipp-migration-agent/Dockerfile",
      },
    },
    default + {
      name: "ui-tests-agent",
      labels: ["ui-test", "ui-tests", ],
      docker+: {
        raw_dockerfile: importstr "ui-tests-agent/Dockerfile",
      },
    },
  ]
}