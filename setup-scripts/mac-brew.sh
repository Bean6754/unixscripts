#!/bin/bash

# Needs Bash for Homebrew script to run.

# Xcode dependancies.
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools.
# sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Install Homebrew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Update system.
brew update
brew upgrade

# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

brew install vim --with-override-system-vi

# git curl wget python, already installed from Xcode utils.
brew install zsh neofetch htop lua python2 python3 telnet nmap nethogs iftop arping arpoison arp-scan tmux
# Security.
brew install clamav
