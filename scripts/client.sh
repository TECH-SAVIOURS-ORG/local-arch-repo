#!/bin/bash
# Variables
real_user=$SUDO_USER

# rsync daemon credentials
read -p "Enter your archive server ip address: " server
read -p "Enter your user for rsync daemon credentials: " user
while true; do
  read -s -p "Enter your password: " password
  echo
  read -s -p "Password (again): " password2
  echo
  [ "$password" = "$password2" ] && break
  echo "Please try again"
done

# Hooks
mkdir /etc/pacman.d/hooks/
cp hooks/1.cleanup_cache.hook /etc/pacman.d/hooks/
cp hooks/2.archive_packages-client.hook /etc/pacman.d/hooks/2.archive_packages.hook

# Script/s
cp scripts/archive_packages.sh /root/
chmod +x /root/archive_packages.sh

if aurhelper=$(pacman -Qmq | grep -E 'yay|pikaur|paru|trizen') ; then
	echo "Set $aurhelper rsync command to archive_packages.sh script."
  echo "rsync -chavzP --password-file=/etc/rsyncd.password --ignore-existing /home/$real_user/.cache/$aurhelper/pkg/* rsync://\$user@\$server/archiverepo/archlinux/\$arch/aur" >> /root/archive_packages.sh
else
	echo "No AUR helper installed."
fi

# Rsync credentials
echo "$user" > /etc/rsyncd.user
echo "$password" > /etc/rsyncd.password
echo "$server" > /etc/rsyncd.server
chmod 400 /etc/rsyncd.user /etc/rsyncd.password /etc/rsyncd.server

# Add repository to pacman.conf. May cause a version problem with the other repos. Enable it if you need it. 
if aurhelper=$(pacman -Qmq | grep -E 'yay|pikaur|paru|trizen') ; then
	echo "Add $aurhelper AUR helper to pacmans repos."
  echo "#[homerepo-aur]
#Server = http://$server:8080/archlinux/\$arch/aur
#SigLevel = Never" >> /etc/pacman.conf
else
	echo "No AUR helper installed."
fi
echo "#[homerepo]
#Server = http://$server:8080/archlinux/\$arch" >> /etc/pacman.conf