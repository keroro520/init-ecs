#!/bin/sh

set -o errexit
set -x

# Docker sources
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Yarn sources
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update && \
sudo apt-get install -y \
    software-properties-common \
    gnupg \
    curl \
    git \
    gcc \
    g++ \
    pkg-config \
    libssl-dev \
    make \
    jq \
    net-tools \
    p7zip-full \
    zip \
    llvm \
    build-essential \
    ca-certificates \
    lsb-release \
    tig \
    mosh \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    yarn

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Rust Cargo
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Configure Mosh Server, port is 60001/60002
sudo echo \
'LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
LANG="en_US.UTF-8"' > locale && sudo mv locale /etc/default/locale && mosh-server new
