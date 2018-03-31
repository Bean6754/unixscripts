#!/bin/tcsh

# Xcode dependancies.
xcode-select --install # Install Command Line Tools if you haven't already.
sudo xcode-select --switch /Library/Developer/CommandLineTools # Enable command line tools.
# sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Install MacPorts.
curl -L -O https://github.com/macports/macports-base/releases/download/v2.4.2/MacPorts-2.4.2.tar.bz2
tar xjvf MacPorts-2.4.2.tar.bz2
cd MacPorts-2.4.2
./configure
make
sudo make install
cd ..
rm -rf MacPorts-2.4.2*

# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

# Just in case..
sudo rm -rf /opt/local/var/macports/registry/.registry.lock

# Update MacPorts.
sudo /opt/local/bin/port -v selfupdate
sudo /opt/local/bin/port -v upgrade outdated
# Install software.
sudo /opt/local/bin/port -v install arping arp-scan clamav dsniff ettercap iftop htop lua neofetch nmap python27 python36 tcsh tmux vim
# Get mpv, iTerm2 and transmission online, they selfupdate.
# Setup python2 and python3.
sudo /opt/local/bin/port select --set python python27
sudo /opt/local/bin/port select --set python3 python36
