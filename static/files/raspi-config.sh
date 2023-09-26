#!/bin/bash
# -*- ENCODING: UTF-8 -*-

# Raspberry custom init config script
# Updated on 20181120
# Created on 20181106
# Developed by Sherlockes
# www.sherblog.pro/files/raspiconfig.sh
# Description
#	- Firmware & Packages update
#	- Change Pi password
#	- Configure local network
#	- Configure timezone & locale
#	- Install Git
#	- Install Pi-Hole
#	- Install Hugo
#	- Install Rclone
#   - Installing pivpn server
#	- Schedule daily restart

#Definiciones
password1="YOURPASS" # New Pi user pass
ipadress=192.168.1.202 # New IP Direction
gateway=192.168.1.1 # Router IP

# Modificamos el password para el usuario pi
sudo echo -e "raspberry\n$password1\n$password1" | passwd pi

### Updating...
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install rpi-update
sudo rpi-update

### Network Config
sudo echo 'interface eth0' >> /etc/dhcpcd.conf
sudo echo 'static ip_address=$ipadress/24' >> /etc/dhcpcd.conf
sudo echo 'static routers=$gateway' >> /etc/dhcpcd.conf
sudo echo 'static domain_name_servers=$gateway' >> /etc/dhcpcd.conf

### Change Timezone & Locale
sudo dpkg-reconfigure tzdata
sudo dpkg-reconfigure locales

### Installing Git
sudo apt-get install git -y
sudo apt-get install jq -y

### Installing Pi-hole Web interface http://ip/admin
curl -sSL https://install.pi-hole.net | bash
sudo echo -e "$password1\n$password1" | pihole -a -p

### Installing latest version of Hugo
curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest \
| grep "browser_download_url.*hugo_[^extended].*_Linux-ARM\.deb" \
| cut -d ":" -f 2,3 \
| tr -d \" \
| wget -qi -
installer="$(find . -name "*Linux-ARM.deb")"
sudo dpkg -i $installer
rm $installer

### Installing Rclone
curl -s https://api.github.com/repos/ncw/rclone/releases/latest \
| grep "browser_download_url.*rclone-[^extended].*-linux-arm\.deb" \
| cut -d ":" -f 2,3 \
| tr -d \" \
| wget -qi -
installer="$(find . -name "*linux-arm.deb")"
sudo dpkg -i $installer
rm $installer

### Installing vpn server
curl -L https://install.pivpn.io | bash

### Schedule Raspberry reboot at 4 A.M.
echo "00 04 * * * /sbin/reboot" | cat > cron
sudo crontab cron
rm cron

### Raspberry Reboot
sudo reboot