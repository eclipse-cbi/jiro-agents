#*******************************************************************************
# Copyright (c) 2023 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
FROM ubuntu:24.04

ENV JAVA_HOME=/opt/java/openjdk
COPY --from=ibm-semeru-runtimes:open-17-jdk $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y software-properties-common \
  && add-apt-repository -y ppa:git-core/ppa

RUN apt-get upgrade -y && apt-get install -y --no-install-recommends \
  bash \
  coreutils \
  curl \
  dumb-init \
  git \
  git-lfs \
  gnupg \
  jq \
  openssh-client \
  rsync \
  fonts-dejavu \
  unzip \
  wget \
  zip

RUN ln -sf /bin/bash /bin/sh
