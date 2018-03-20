#!/bin/csh

# Xcode dependancies.
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools.
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Install MacPorts.
curl -L -O https://github.com/macports/macports-base/releases/download/v2.4.2/MacPorts-2.4.2.tar.bz2
tar xjvf MacPorts-2.4.2.tar.bz2

# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

# Update MacPorts.
sudo /opt/local/bin/port -v selfupdate
# Install software.
sudo /opt/local/bin/port -v install arping arp-scan clamav dsniff ettercap iftop htop lua nmap python27 python36 tcsh tmux vim
# Setup python2 and python3.
sudo /opt/local/bin/port select --set python python27
sudo /opt/local/bin/port select --set python3 python36
