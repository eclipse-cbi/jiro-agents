#!/usr/bin/env bash
#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************

# See http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o errexit
set -o nounset
set -o pipefail

IFS=$'\n\t'

# export this variable with another value if another file should be used
SYMLINKS_FILE="${SYMLINKS_FILE:-"/usr/share/jenkins-agent/symlinks"}"

if [[ -f "${SYMLINKS_FILE}" ]]; then
  while read -r symlink || [[ -n "${symlink}" ]]; do
    #trim whitespaces
    symlink="$(echo -e "${symlink}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    s=$(cut -d';' -f1 <<<"${symlink}")
    t=$(cut -d';' -f2 <<<"${symlink}")
    mkdir -p "$(dirname "${s}")"
    if ln -s "${s}" "${t}"; then
      >&2 echo "INFO: Created symlink from ${t} -> ${s}"
    else
      >&2 echo "WARNING: Cannot create symlink from ${t} -> ${s}"
    fi
  done < "${SYMLINKS_FILE}"
else
  >&2 echo "INFO: File ${SYMLINKS_FILE} does not exist."
fi

if [[ ${#} -ge 1 ]]; then
  # another scripts has been requested to start after this one, execute it
  exec "$@"
fi