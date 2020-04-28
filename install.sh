#!/usr/bin/env bash
set -eux

if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi
# Update apt and install essential packages
apt update
apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    curl \
    docker.io \
    vim \
    git \
    wget \
    -y

# Install Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.2-amd64.deb
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./slack*.deb ./google*.deb
rm slack-desktop-4.4.2-amd64.deb google-chrome-stable_current_amd64.deb
# Add myself to docker group
usermod -aG docker bryan

# Add jetbrains PPA from the 
curl -s https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc | sudo apt-key add -
echo "deb http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null
apt update -y

# Install jetbrains products
apt install pycharm-community intellij-idea-community datagrip -y

# Switch to ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
