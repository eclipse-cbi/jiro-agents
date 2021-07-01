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
  latest: "4.5",
  releases: [
    default + {
      // Included since 2.296 (2021-06-01)
      version: "4.9",
      startupScript+: {
        version: "4.9-1",
      },
    },
    // This one is commented has it may never appear in any LTS
    // default + {
    //   // Included since 2.294 (2021-05-26)
    //   version: "4.8",
    //   startupScript+: {
    //     version: "4.7-1",
    //   },
    // },
    default + {
      // Included since 2.282 (2021-03-02)
      version: "4.7",
      startupScript+: {
        version: "4.7-1",
      },
    },
    default + {
      // Included since 2.266 (2020-11-10)
      version: "4.6",
      startupScript+: {
        version: "4.6-1",
      },
    },
    default + {
      // included since 2.248 (2020-07-21)
      version: "4.5",
      startupScript+: {
        version: "4.3-9",
      },
    },
  ],
}