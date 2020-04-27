#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
FROM eclipsecbi/fedora:29

RUN dnf -y update && dnf -y install \
      curl \
      dejavu-fonts-common \
      git \
      gtk3 \
      gnu-free-fonts-common \
      gnupg \
      java-1.8.0-openjdk.x86_64 \
      liberation-fonts \
      mesa-libGL \
      mutter \
      openssh-clients \
      tigervnc-server \
      tigervnc \
      unzip \
      wget \
      xorg-x11-server-utils \
      xorg-x11-fonts-misc \
      xorg-x11-fonts-75dpi \
      xorg-x11-fonts-Type1 \
      xorg-x11-fonts-100dpi \
      zip \
    && dnf clean all

ENV DISPLAY :0

RUN mkdir -p %(home)s/.vnc && chmod -R 775 %(home)s \
  && echo "123456" | vncpasswd -f > %(home)s/.vnc/passwd \
  && chmod 600 %(home)s/.vnc/passwd

# Create a custom vnc xstartup file
COPY scripts/xstartup_mutter.sh %(home)s/.vnc/xstartup.sh
RUN chmod 755 %(home)s/.vnc/xstartup.sh
