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
  latest: "4.11.2",
  releases: [
    default + {
      // Included since 2.346.1 (2022-06-22)
      version: "4.13.2",
      startupScript+: {
        version: "4.13.2-1",
      },
    },
    default + {
      // Included since 2.338 (2022-03-08)
      version: "4.13",
      startupScript+: {
        version: "4.13-2",
      },
    },
    default + {
      // Included since 2.335 (2022-02-15)
      version: "4.12",
      startupScript+: {
        version: "4.11.2-4",
      },
    },
    default + {
      // Included since 2.317 (2021-10-19)
      version: "4.11.2",
      startupScript+: {
        version: "4.11.2-4",
      },
    },
  ],
}