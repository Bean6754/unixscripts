## DO NOT USE YET!

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

# make.conf stuff.
echo 'CFLAGS="-march=native -O2 -pipe"' > /etc/portage/make.conf
echo 'CXXFLAGS="${CFLAGS}"' >> /etc/portage/make.conf
echo 'CHOST="x86_64-pc-linux-gnu"' >> /etc/portage/make.conf
echo 'USE="bindlist dbus -gtk -qt4 -qt5 -kde -gnome alsa pulseaudio dvd alsa cdr"' >> /etc/portage/make.conf
echo 'CPU_FLAGS_X86="mmx sse sse2"' >> /etc/portage/make.conf
echo 'PORTDIR="/usr/portage"' >> /etc/portage/make.conf
echo 'DISTDIR="${PORTDIR}/distfiles"' >> /etc/portage/make.conf
echo 'PKGDIR="${PORTDIR}/packages"' >> /etc/portage/make.conf
emerge -v app-portage/cpuid2cpuflags
cpuinfo2cpuflags-x86 >> /etc/portage/make.conf
#cat /proc/cpuinfo | grep processor | wc -l >> /etc/portage/make.conf
echo 'MAKEOPTS="-j4"' >> /etc/portage/make.conf
echo 'GENTOO_MIRRORS="ftp://mirror.bytemark.co.uk/gentoo/ http://mirror.bytemark.co.uk/gentoo/ rsync://mirror.bytemark.co.uk/gentoo/"' >> /etc/portage/make.conf
echo 'VIDEO_CARDS="nvidia"' >> /etc/portage/make.conf
echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf
echo 'ABI_X86="amd64"' >> /etc/portage/make.conf

eselect profile set 1
emerge --update --deep --newuse @world

rm -rf /etc/timezone
echo "Europe/London" > /etc/timezone
emerge --config sys-libs/timezone-data
echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
locale-gen
eselect locale set 3
env-update && source /etc/profile

emerge -v app-admin/sudo dev-util/cmake dev-vcs/git sys-devel/autoconf sys-devel/autogen sys-devel/automake sys-devel/binutils sys-devel/m4 sys-devel/make sys-devel/patch sys-devel/gcc x11-base/xorg-x11 media-fonts/droid media-fonts/noto www-client/firefox unrar rar zip unzip p7zip xarchiver urxvt rofi feh redshift i3 i3lock i3status i3blocks media-libs/alsa-lib media-sound/alsa-utils media-plugins/alsa-plugins media-sound/pulseaudio pavucontrol htop

rc-update add consolekit default

#gpasswd -d $USER audio

exit 0
