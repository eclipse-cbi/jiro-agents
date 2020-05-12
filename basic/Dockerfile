#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
FROM eclipsecbi/adoptopenjdk-coreutils:openjdk8-openj9-alpine-slim

# TODO: removed once LTS 2.222.1 is deployed everywhere
ENV JAVA_TOOL_OPTIONS="-XX:+IgnoreUnrecognizedVMOptions -XX:+UseContainerSupport"