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
  latest: "3160.vd76b_9ddd10cc",
  releases: [
    default + {
      // Included since LTS 2.426.1
      version: "3160.vd76b_9ddd10cc",
      startupScript+: {
        version: "3160.vd76b_9ddd10cc-3",
        url: "https://github.com/jenkinsci/docker-inbound-agent/raw/%s/jenkins-agent" % [ self.version]
      },
    },
    default + {
      // Included since LTS 2.440.1
      version: "3206.vb_15dcf73f6a_9",
      startupScript+: {
        version: "3206.vb_15dcf73f6a_9-4",
      },
    },
  ],
}