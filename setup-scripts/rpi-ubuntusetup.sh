#!/bin/bash

# Prefer 'sudo' to 'su' because it's Ubuntu.

# For Raspberry Pi 3 B+.
# From: https://www.invik.xyz/linux/Ubuntu-Server-18-04-1-RasPi3Bp/

mkdir -v firmware
cd firmware
wget http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/libraspberrypi-bin_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/libraspberrypi-dev_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/libraspberrypi-doc_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/libraspberrypi0_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-bootloader_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel_1.20180817-1_armhf.deb http://archive.raspberrypi.org/debian/pool/main/r/raspberrypi-firmware/raspberrypi-kernel-headers_1.20180817-1_armhf.deb

# Uninstall all old raspi2 packages.
sudo apt purge -y *raspi2*
# Install new raspi packages.
sudo dpkg -i *.deb

# WiFi.
mkdir -v wifi-firmware
cd wifi-firmware
# Pi 3B
# wget https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac43430-sdio.bin
# wget https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac43430-sdio.txt
# Pi 3B+
wget https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac43455-sdio.bin
wget https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac43455-sdio.clm_blob
wget https://github.com/RPi-Distro/firmware-nonfree/raw/master/brcm/brcmfmac43455-sdio.txt 
sudo cp *sdio* /lib/firmware/brcm/
cd ../..

clear
echo Finished.
echo Please run a 'sudo reboot' to re-enable new kernel and freshly installed WiFi firmware.
