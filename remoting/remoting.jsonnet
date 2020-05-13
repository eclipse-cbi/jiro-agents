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
  # See https://github.com/jenkinsci/remoting/releases for the remoting version
  # See https://github.com/jenkinsci/docker-inbound-agent/releases for the startupScript.version
  latest: "4.3",
  releases: [
    default + {
      version: "4.3",
      startupScript+: {
        version: "4.3-4",
      },
    },
    default + {
      version: "4.2.1",
      startupScript+: {
        version: "4.0.1-1",
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
  ],
}