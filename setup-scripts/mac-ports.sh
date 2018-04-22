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

# Port var. (temp)
export port='/opt/local/bin/port'

# Update MacPorts.
sudo $port -v selfupdate
# To view outdated packages: sudo $port -v outdated
sudo $port -v upgrade outdated
# Install software.
sudo $port -v install arping arp-scan autoconf automake bash clamav coreutils dsniff ettercap iftop htop libplist lua neofetch nmap python27 python36 py27-pip py36-pip rsync screen texlive tmux vim
# Get mpv, iTerm2 and transmission online, they selfupdate.
# Setup python2 and python3.
sudo $port select --set python2 python27
sudo $port select --set python python36
sudo $port select --set cython cython36
sudo $port select --set pip pip36

# For some reason you have to do this 4+ times for it to actually work.. :/
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves
sudo $port -v uninstall leaves

