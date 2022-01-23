#!/bin/bash
# Variables
read -p "Enter your archive server ip address: " server
read -p "Enter your user for rsync daemon credentials: " user
read -p "Enter your password: " -s password

# Hooks
mkdir /etc/pacman.d/hooks/
cp hooks/1.cleanup_cache.hook /etc/pacman.d/hooks/
cp hooks/2.archive_packages-client.hook /etc/pacman.d/hooks/2.archive_packages.hook

# Script/s
cp scripts/archive_packages.sh /root/
chmod +x /root/archive_packages.sh

# Rsync credentials
echo "$user" > /etc/rsyncd.user
echo "$password" > /etc/rsyncd.password
echo "$server" > /etc/rsyncd.server
chmod 400 /etc/rsyncd.user /etc/rsyncd.password /etc/rsyncd.server

# Add repository to pacman.conf
echo "[homerepo]
Server = http://$server:8080/archlinux/\$arch" >> /etc/pacman.conf