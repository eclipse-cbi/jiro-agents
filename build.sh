#!/usr/bin/env bash
#*******************************************************************************
# Copyright (c) 2019 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************

# Bash strict-mode
set -o errexit
set -o nounset
set -o pipefail

IFS=$'\n\t'

SCRIPT_FOLDER="$(dirname "$(readlink -f "${0}")")"

jsonnet="${SCRIPT_FOLDER}/.jsonnet/jsonnet"

for agent in $("${jsonnet}" "${SCRIPT_FOLDER}/remoting.libsonnet" | jq -r '.agents|keys[]'); do
  agentFolder=${SCRIPT_FOLDER}/$("${jsonnet}" "${SCRIPT_FOLDER}/remoting.libsonnet" | jq -r '.agents["'"${agent}"'"].folder')
  echo "INFO: Building agents ${agent} in '${agentFolder}/'"

  mkdir -p "${agentFolder}/target"

  for agentVersion in $("${jsonnet}" "${SCRIPT_FOLDER}/remoting.libsonnet" | jq -r '.agents["'"${agent}"'"].versions|keys[]'); do
    echo "INFO: Building agent ${agent}:${agentVersion}"
    dockerfile="${agentFolder}/target/Dockerfile_${agentVersion}"
    manifest="${agentFolder}/target/manifest_${agentVersion}.json"
    "${jsonnet}" "${SCRIPT_FOLDER}/remoting.libsonnet" | jq '.agents["'"${agent}"'"].versions["'"${agentVersion}"'"]' > "${manifest}"

    hbs -s -P "${SCRIPT_FOLDER}/Dockerfile.agentSetup.hbs" -D "${manifest}" "${agentFolder}/Dockerfile.hbs" > "${dockerfile}"

    dockerRepo="$("${jsonnet}" "${manifest}" | jq -r '.docker.repository')"
    imageName="$("${jsonnet}" "${manifest}" | jq -r '.docker.image.name')"
    imageTag="$("${jsonnet}" "${manifest}" | jq -r '.docker.image.tag')"

    "${SCRIPT_FOLDER}/.dockertools/dockerw" build "${dockerRepo}/${imageName}" "${imageTag}" "${dockerfile}" "${agentFolder}" "true" "false"
  done
done
