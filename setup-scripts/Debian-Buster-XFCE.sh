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
# tasksel install desktop
# tasksel install xfce-desktop
# tasksel install print-server
# tasksel install ssh-server
# tasksel install web-server

# Low-level
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip rar unrar scanmem strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp
# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam
# High-level
apt purge -y vlc
apt autoremove
apt install -y kdenlive qt5-default qt5-style-plugins wireshark-gtk transmission-gtk audacity mpv pavucontrol xarchiver menulibre gameconqueror geany geany-plugins glade baobab filezilla gparted gimp redshift redshift-gtk pidgin firefox-esr firefox-esr-l10n-en-gb thunderbird thunderbird-l10n-en-gb libreoffice libreoffice-l10n-en-gb gpick conky-all guvcview simplescreenrecorder wmctrl playonlinux virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
# Setup decent Qt4 and Qt5 theming.
echo 'QT_QPA_PLATFORMTHEME=gtk2' >> /etc/environment
echo 'QT_STYLE_OVERRIDE=gtk2' >> /etc/environment
read -p 'Please enter your NON-ROOT username: ' username
sudo -H -u $username bash -c 'echo >> ~/.config/Trolltech.conf'
sudo -H -u $username bash -c 'echo "[Qt]" >> ~/.config/Trolltech.conf' 
sudo -H -u $username bash -c 'echo "style=GTK+" >> ~/.config/Trolltech.conf'

# Codecs
apt install -y ffmpeg libdvdnav4 libdvdread4 libdvdcss2 libbluray2
dpkg-reconfigure libdvd-pkg
# Flash player.
# apt install -y browser-plugin-freshplayer-pepperflash or flashplugin-nonfree
# Emoji and other fonts.
apt install -y fonts-noto fonts-noto-mono fonts-symbola ttf-ancient-fonts-symbola fonts-liberation fonts-liberation2 ttf-mscorefonts-installer fonts-dejavu fonts-dejavu-extra
# Themes.
apt install -y arc-theme chameleon-cursor-theme moka-icon-theme xfwm4-themes
# Java.
apt install -y openjdk-10-jdk
# Server specific stuff.
systemctl stop apache2
apt install -y mariadb-server mariadb-client php7.2 php-pear php7.2-fpm php7.2-mysql nginx
# Don't autostart services, workstation/laptop security.

# To enable service: update-rc.d apache2 defaults
# init.
# update-rc.d -f apache2 remove
# update-rc.d -f php7.2-fpm remove
# update-rc.d -f nginx remove
# update-rc.d -f mariadb remove

# systemd.
systemctl disable apache2
systemctl disable php7.2-fpm
systemctl disable nginx
systemctl disable mariadb
systemctl disable mysql

systemctl stop apache2
systemctl stop php7.2-fpm
systemctl stop nginx
systemctl stop mariadb
systemctl stop mysql

systemctl start mariadb
mysql_secure_installation
systemctl stop mariadb

touch ~/web.sh
cat >~/web.sh << EOL
#!/bin/bash

start() {
  systemctl start php7.2-fpm
  systemctl start nginx
  systemctl start mariadb
}

stop() {
  systemctl stop php7.2-fpm
  systemctl stop nginx
  systemctl stop mariadb
}

case $1 in
  start|stop) "$1" ;;
esac
EOL
chmod +x ~/web.sh
