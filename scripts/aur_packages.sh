#!/bin/bash

# Variables
arch=$(uname -m)
## Add your archive server ip and user (rsync auth user)
server="$(cat /etc/rsyncd.server)"
user="$(cat /etc/rsyncd.user)"
real_user=$SUDO_USER
aurhelper=$(pacman -Qmq | grep -E 'yay|pikaur|paru|trizen') 

# Rsync daemon
rsync -chavzP --password-file=/etc/rsyncd.password --ignore-existing /home/$real_user/.cache/$aurhelper/pkg/* rsync://$user@$server/archiverepo/archlinux/$arch/aur
