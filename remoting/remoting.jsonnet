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
      // Included since 2.361.1 (2022-09-07)
      version: "3044.vb_940a_a_e4f72e",
      startupScript+: {
        version: "3046.v38db_38a_b_7a_86-1",
      },
    },
    default + {
      // Included since 2.346.3 (2022-08-10)
      version: "4.13.3",
      startupScript+: {
        version: "4.13.2-1",
      },
    },
    default + {
      // Included since 2.346.1 (2022-06-22)
      version: "4.13.2",
      startupScript+: {
        version: "4.13.2-1",
      },
    },
  ],
}