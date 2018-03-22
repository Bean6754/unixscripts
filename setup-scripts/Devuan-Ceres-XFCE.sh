#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

## Make sure free, non-free and contrib are enabled.
dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y
apt autoremove -y

# Tasksel stuff.
# tasksel install lxqt-desktop
# tasksel install print-server
# tasksel install ssh-server
# tasksel install web-server

# Low-level
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip scanmem strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp
# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam
# High-level
apt purge -y vlc
apt autoremove -y
apt install -y wireshark-gtk transmission-gtk audacity mpv pavucontrol xarchiver menulibre gameconqueror geany geany-plugins glade baobab filezilla gparted gimp redshift redshift-gtk pidgin firefox-esr firefox-esr-l10n-en-gb thunderbird thunderbird-l10n-en-gb libreoffice libreoffice-l10n-en-gb gpick conky-all guvcview simplescreenrecorder wmctrl playonlinux gnome-boxes
# Codecs
apt install -y ffmpeg libdvdnav4 libdvdread4 libdvdcss2 libbluray1
dpkg-reconfigure libdvd-pkg
# Flash player.
apt install -y browser-plugin-freshplayer-pepperflash
# Emoji and other fonts.
apt install -y fonts-noto fonts-noto-mono fonts-symbola ttf-ancient-fonts-symbola fonts-liberation fonts-liberation2 ttf-mscorefonts-installer fonts-dejavu fonts-dejavu-extra
# Themes.
apt install -y arc-theme chameleon-cursor-theme moka-icon-theme xfwm4-themes
# Java.
apt install -y openjdk-8-jdk icedtea-8-plugin
# Server specific stuff.
service apache2 stop
apt install -y mariadb-server mariadb-client php7.0 php-pear php7.0-fpm php7.0-mysql nginx
# Don't autostart services, workstation/laptop security.
# To enable service: update-rc.d apache2 defaults
update-rc.d -f apache2 remove
update-rc.d -f php7.0-fpm remove
update-rc.d -f nginx remove
update-rc.d -f mysql remove
mysql_secure_installation

touch ~/web.sh
echo '#!/bin/bash' > ~/web.sh
echo >> ~/web.sh
echo 'service php7.0-fpm start' >> ~/web.sh
echo 'service nginx start' >> ~/web.sh
echo 'service mysql start' >> ~/web.sh
chmod +x ~/web.sh
