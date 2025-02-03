#*******************************************************************************
# Copyright (c) 2023 Eclipse Foundation and others.
# This program and the accompanying materials are made available
# under the terms of the Eclipse Public License 2.0
# which is available at http://www.eclipse.org/legal/epl-v20.html,
# or the MIT License which is available at https://opensource.org/licenses/MIT.
# SPDX-License-Identifier: EPL-2.0 OR MIT
#*******************************************************************************
ARG FROM_TAG="open-17-jdk-jammy"
FROM ibm-semeru-runtimes:${FROM_TAG}

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

# Set environment variables to non-interactive for automatic installations
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and CA certificates
RUN apt-get update && \
    apt-get install -y wget gnupg curl ca-certificates --no-install-recommends && \
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable --no-install-recommends && \
    apt-get install -y \
        fonts-liberation \
        libappindicator3-1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdbus-1-3 \
        libgdk-pixbuf2.0-0 \
        libnspr4 \
        libnss3 \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        xdg-utils \
        --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/apt/sources.list.d/google-chrome.list

# Set the working directory
WORKDIR /usr/src/app

# Verify installation
RUN google-chrome --version

# Clean up
RUN apt-get purge -y --auto-remove wget gnupg curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Default command to run Chrome
CMD ["google-chrome", "--headless", "--no-sandbox", "--disable-gpu"]

