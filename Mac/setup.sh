#!/bin/bash


# Xcode dependancies.
xcode-select --install # Install Command Line Tools if you haven't already.

# Install Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update system.
brew update
brew upgrade

## Some are default in '/etc/paths'.
echo 'export PATH="$PATH:/usr/local/bin:/usr/local/sbin"' >> ~/.bash_profile
echo 'export PATH="$PATH:/usr/local/bin:/usr/local/sbin"' >> ~/.zshrc
# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

brew install curl wget bash emacs nano git openssh perl rsync svn unzip vim

# Setup bash for local user.
sudo bash -c 'cat >> /etc/shells << EOF
# Brew.
/usr/local/bin/bash
EOF'
chsh -s /usr/local/bin/bash

# git curl wget python, already installed from Xcode utils.
brew install arping arpoison arp-scan bash-completion cmus ettercap htop iftop lua neofetch nmap nethogs telnet tmux tor tree mc youtube-dl
brew link bash-completion
# Fun.
brew install cowsay figlet lolcat toilet
# Web-server.
# brew install apache2 php
