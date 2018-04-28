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
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip rar unrar scanmem strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp
# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam
# High-level
apt install -y kdenlive qt5-style-plugins wireshark-gtk transmission-gtk audacity vlc pavucontrol xarchiver menulibre gameconqueror geany geany-plugins glade baobab filezilla gparted gimp redshift redshift-gtk pidgin firefox-esr firefox-esr-l10n-en-gb thunderbird thunderbird-l10n-en-gb libreoffice libreoffice-l10n-en-gb gpick conky-all guvcview simplescreenrecorder wmctrl playonlinux
# Setup decent Qt4 and Qt5 theming.
echo 'QT_QPA_PLATFORMTHEME=gtk2' >> /etc/environment
echo 'QT_STYLE_OVERRIDE=gtk2' >> /etc/environment
read -p 'Please enter your NON-ROOT username: ' username
sudo -H -u $username bash -c 'echo >> ~/.config/Trolltech.conf'
sudo -H -u $username bash -c 'echo "[Qt]" >> ~/.config/Trolltech.conf' 
sudo -H -u $username bash -c 'echo "style=GTK+" >> ~/.config/Trolltech.conf'

# Codecs
apt install -y ffmpeg libdvdnav4 libdvdread4 libdvdcss2 libbluray1
dpkg-reconfigure libdvd-pkg
# VirtualBox.
curl -LO https://download.virtualbox.org/virtualbox/5.2.10/virtualbox-5.2_5.2.10-122088~Debian~stretch_amd64.deb
dpkg -i virtualbox-5.2_5.2.10-122088~Debian~stretch_amd64.deb
apt install -f # Just in case. ;)
curl -LO https://download.virtualbox.org/virtualbox/5.2.10/Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack
rm -rf virtualbox-5.2_5.2.10-122088~Debian~stretch_amd64.deb
rm -rf Oracle_VM_VirtualBox_Extension_Pack-5.2.10.vbox-extpack

# Flash player.
# apt install -y browser-plugin-freshplayer-pepperflash or flashplugin-nonfree
# Emoji and other fonts.
apt install -y fonts-noto fonts-noto-mono fonts-symbola ttf-ancient-fonts-symbola fonts-liberation fonts-liberation2 ttf-mscorefonts-installer fonts-dejavu fonts-dejavu-extra
# Themes.
apt install -y arc-theme blackbird-gtk-theme chameleon-cursor-theme moka-icon-theme xfwm4-themes
# Java.
apt install -y openjdk-8-jdk
# Server specific stuff.
systemctl stop apache2
apt install -y mariadb-server mariadb-client php7.0 php-pear php7.0-fpm php7.0-mysql nginx
# Don't autostart services, workstation/laptop security.

# To enable service: update-rc.d apache2 defaults
# init.
# update-rc.d -f apache2 remove
# update-rc.d -f php7.0-fpm remove
# update-rc.d -f nginx remove
# update-rc.d -f mariadb remove

# systemd.
systemctl disable apache2
systemctl disable php7.0-fpm
systemctl disable nginx
systemctl disable mariadb
systemctl disable mysql

systemctl stop apache2
systemctl stop php7.0-fpm
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
  systemctl start php7.0-fpm
  systemctl start nginx
  systemctl start mariadb
}

stop() {
  systemctl stop php7.0-fpm
  systemctl stop nginx
  systemctl stop mariadb
}

case $1 in
  start|stop) "$1" ;;
esac
EOL
chmod +x ~/web.sh
