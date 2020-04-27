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
  # See https://github.com/jenkinsci/docker-jnlp-slave/releases for the jnlpAgentScript.version
  releases: [
    default + {
      version: "4.3",
      startupScript+: {
        version: "4.3-4",
      },
    },
    default + {
      version: "4.2",
      startupScript+: {
        version: "4.0.1-1",
      },
    },
    default + {
      version: "3.36",
      startupScript+: {
        version: "3.36-2",
      },
    },
    default + {
      version: "3.35",
      startupScript+: {
        version: "3.35-5",
      },
    },
  ],
}