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



## Setup GNU coreutils and similar.
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.bash_profile
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.zshrc
# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

brew install coreutils
brew install binutils
brew install diffutils
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install bash
brew install emacs
brew install gdb  # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install less
brew install m4
brew install make
brew install nano
brew install file-formula
brew install git
brew install openssh
brew install perl
brew install python
brew install rsync
brew install svn
brew install unzip
brew install vim --with-override-system-vi
# brew install macvim --with-override-system-vim --custom-system-icons
brew install zsh

# Setup bash for local user.
sudo cat /etc/shells << EOF

# Brew.
/usr/local/bin/bash
EOF
chsh -s /usr/local/bin/bash



# git curl wget python, already installed from Xcode utils.
brew install arping arpoison arp-scan ettercap htop iftop lua neofetch nmap nethogs python2 python3 telnet tmux zsh
# Security.
brew install clamav
# Cask(room) stuff. Usually graphical applications.
brew tap caskroom/cask
brew cask install iterm2 mpv
