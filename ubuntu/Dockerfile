#*******************************************************************************
# Copyright (c) 2023 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
ARG FROM_TAG=""
FROM ubuntu:${FROM_TAG}

RUN apt-get -y update && apt-get install -y --no-install-recommends \
  autoconf \
  automake \
  bash \
  clang \
  cmake \
  coreutils \
  cppcheck \
  createrepo-c \
  curl \
  doxygen \
  dumb-init \
  fonts-liberation \
  fonts-liberation2 \
  fonts-freefont-ttf \
  fonts-dejavu \
  fonts-dejavu-core \
  fonts-dejavu-extra \
  gcc \
  git \
  git-lfs \
  gnupg \
  imagemagick \
  openjdk-17-jdk \
  openjdk-17-dbg \
  jq \
  libgl1-mesa-dri \
  libgtk-3-0 \
  libtool \
  lsof \
  make \
  metacity \
  mutter \
  okular \
  openssh-client \
  patch \
  perl \
  procps \
  python3 \
  rsync \
  strace \
  subversion \
  sysstat \
  tcl \
  tcpdump \
  tcsh \
  telnet \
  texlive \
  texlive-latex-base \
  tk \
  tigervnc-standalone-server \
  tigervnc-common \
  tightvncserver \
  unzip \
  vino \
  wget \
  x11-xserver-utils \
  xfonts-base \
  xfonts-scalable \
  xfonts-100dpi \
  xfonts-75dpi \
  xmlstarlet \
  xterm \
  xz-utils \
  zip \
  zsh

ENV HOME=/home/vnc
ENV DISPLAY=:0
