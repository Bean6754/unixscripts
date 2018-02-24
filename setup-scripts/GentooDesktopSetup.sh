#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
emerge --update --deep --newuse @world

# Portage utils.
emerge -v app-portage/portage-utils app-portage/cpuid2cpuflags
# Low-level.
emerge -v app-admin/sudo dev-util/cmake dev-vcs/git sys-devel/autoconf sys-devel/autogen sys-devel/automake sys-devel/binutils sys-devel/m4 sys-devel/make sys-devel/patch sys-devel/gcc htop dbus strace
# High-level.
emerge -v x11-base/xorg-x11 media-fonts/droid media-fonts/noto www-client/firefox unrar rar zip unzip p7zip xarchiver rxvt-unicode rofi feh redshift i3 i3lock i3status i3blocks media-libs/alsa-lib media-sound/alsa-utils media-plugins/alsa-plugins media-sound/pulseaudio pavucontrol x11-drivers/nvidia-drivers

eselect opengl set nvidia
eselect opencl set nvidia

rc-update add dbus default
rc-update add consolekit default

#gpasswd -d $USER audio
