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
  # See https://github.com/jenkinsci/docker-agent/releases for the startupScript.version
  latest: "3206.3208.v409508a_675ff",
  releases: [
    default + {
      // Used for 2.452.4
      version: "3206.3208.v409508a_675ff",
      startupScript+: {
        version: "3206.vb_15dcf73f6a_9-12",
      },
    },
  ],
}