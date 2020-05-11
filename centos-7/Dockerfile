#*******************************************************************************
# Copyright (c) 2020 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
FROM eclipsecbi/centos:7


RUN yum install -y \
    autoconf \
    automake \
    boost-test \
    blas \
    blas-devel \
    cmake \
    cppcheck \
    createrepo \
    curl \
    doxygen \
    e2fsprogs-devel \
    gcc \
    gcc-c++ \
    git \
    gtk3 \
    # Required for python36u
    https://centos7.iuscommunity.org/ius-release.rpm \
    ImageMagick \
    ImageMagick-devel \
    lapack \
    lapack-devel \
    libclang \
    libgtk-vnc-2.0-0 \
    libtool \
    libXtst \
    lsof \
    mailx \
    make \
    makeinfo \
    mariadb-libs \
    metacity \
    mutter \
    net-snmp-devel.x86_64 \
    okular \
    java-1.8.0-openjdk-devel \
    openssl-devel.x86_64 \
    patch \
    perl \
    perl-LDAP \
    python-gtk-vnc \
    python36u\
    rpm-build \
    strace \
    subversion \
    sysstat \
    tcl \
    tcpdump \
    tcsh \
    telnet \
    texlive \
    texlive-latex \
    texlive-tex4ht \
    tigervnc \
    tigervnc-server \
    tk \
    unrar \
    unzip \
    vino \
    webkitgtk \
    webkitgtk3 \
    webkitgtk4 \
    wget \
    xmlstarlet \
    xorg-x11-apps.x86_64 \
    xorg-x11-drv-dummy.x86_64 \
    xorg-x11-drv-evdev.x86_64 \
    xorg-x11-drv-fbdev.x86_64 \
    xorg-x11-drv-keyboard.x86_64 \
    xorg-x11-drv-mouse.x86_64 \
    xorg-x11-drv-synaptics.x86_64 \
    xorg-x11-drv-vmmouse.x86_64 \
    xorg-x11-drv-void.x86_64 \
    xorg-x11-server-Xvfb.x86_64 \
    xterm \
    # Required for python36u
    yum-utils \
    zip \
    zsh \
  && yum clean all

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
