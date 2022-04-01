#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
FROM eclipsecbi/centos:8

# See https://fedoraproject.org/wiki/EPEL
RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \ 
  && dnf install -y 'dnf-command(config-manager)' \
  && dnf config-manager --set-enabled powertools \
  && dnf groupinstall -y "Development Tools" \
  && dnf install -y \
    coreutils-single \
    cmake \
    cppcheck \
    glibc-langpack-en \
    gtk3 \
    ImageMagick \
    java-11-openjdk-devel \
    jq \
    mutter \
    python3 \
    tigervnc \
    tigervnc-server \
    webkitgtk4 \
    wget \
    xorg-x11-server-Xvfb.x86_64 \
    xterm \
    xz \
    zsh \
  && dnf clean all

RUN ln -s /usr/bin/git /usr/local/bin/git \
  && ln -s /bin/bash /usr/local/bin/hipp_shell \
  && if [ ! -a /etc/machine-id ] || [ ! -s /etc/machine-id ]; then dbus-uuidgen > /etc/machine-id; fi

ENV DISPLAY :0

RUN mkdir -p %(home)s/.vnc && chmod -R 775 %(home)s \
  && echo "123456" | vncpasswd -f > %(home)s/.vnc/passwd \
  && chmod 600 %(home)s/.vnc/passwd

# Create a custom vnc xstartup file
COPY scripts/xstartup_mutter.sh %(home)s/.vnc/xstartup.sh
RUN chmod 755 %(home)s/.vnc/xstartup.sh

# explicitly set locale
ENV LANG=en_US.UTF-8
