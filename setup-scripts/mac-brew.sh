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

# Setup GNU coreutils and similar.
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.bash_profile
echo 'export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"' >> ~/.zshrc
echo 'MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"' >> ~/.bash_profile
echo 'MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"' >> ~/.zshrc
echo "alias gcc='/usr/local/bin/gcc-7'" >> ~/.bash_profile
echo "alias g++='/usr/local/bin/g++-7'" >> ~/.bash_profile
echo "alias gcc='/usr/local/bin/gcc-7'" >> ~/.zshrc
echo "alias gcc='/usr/local/bin/g++-7'" >> ~/.zshrc

#echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
#echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
# Fix Vim backspace issue.
echo "set backspace=2" >> ~/.vimrc

# GNU ist Liebe.
brew install coreutils --with-default-names
brew install binutils --with-default-names
brew install diffutils --with-default-names
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls --with-default-names
brew install grep --with-default-names
brew install gzip --with-default-names
brew install screen --with-default-names
brew install watch --with-default-names
brew install wdiff --with-gettext --with-default-names
brew install gdb  --with-default-names # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch --with-default-names
brew install less --with-default-names
brew install m4 --with-default-names
brew install make --with-default-names
brew install file-formula --with-default-names

brew install curl wget bash emacs nano git openssh perl rsync svn unzip zsh
brew install vim --with-override-system-vi

# Setup bash for local user.
sudo bash -c 'cat >> /etc/shells << EOF

# Brew.
/usr/local/bin/bash
EOF'
chsh -s /usr/local/bin/bash

# git curl wget python, already installed from Xcode utils.
brew install arping arpoison arp-scan bash-completion ettercap htop iftop lua neofetch nmap nethogs python2 python3 telnet tmux zsh
brew link bash-completion
