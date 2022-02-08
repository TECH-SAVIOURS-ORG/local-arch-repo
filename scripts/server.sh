#!/bin/bash
# Variables
arch=$(uname -m)
server="$(ip addr show | grep "inet " | grep -v 127.0.0. | head -1 | cut -d" " -f6 | cut -d/ -f1)"
## Rsync credentials
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
cp hooks/2.archive_packages-server.hook /etc/pacman.d/hooks/2.archive_packages.hook

# Script/s
cp scripts/repo-add.sh /root/
chmod +x /root/repo-add.sh

# Database
mkdir -p /srv/http/repo/archlinux/{x86_64,aarch64}/aur 
repo-add /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst
repo-add /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst
repo-add /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst
repo-add /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst

# Move existing packages
mv /var/cache/pacman/pkg/*pkg* /srv/http/repo/archlinux/$arch/
repo-add /srv/http/repo/archlinux/$arch/homerepo.db.tar.zst /srv/http/repo/archlinux/$arch/{*.zst,*.gz,*.xz}
chown -R http: /srv/http/repo/

# Change cache path in pacman.conf
sed -i "s|#CacheDir    = /var/cache/pacman/pkg/|CacheDir    = /srv/http/repo/archlinux/$arch/|g" /etc/pacman.conf

# Rsync daemon 
## Credentials
echo "$user:$password" > /etc/rsyncd.secrets
chmod 400 /etc/rsyncd.secrets

## Config
echo "[archiverepo]
path = /srv/http/repo/
comment = Arch Archive Repository
timeout = 300
read only = false
uid = 33
gid = 33
post-xfer exec = /root/repo-add.sh
# Security
auth users = $user      
secrets file = /etc/rsyncd.secrets
# Optional
#hosts allow = 192.168.1.0/255.255.255.0
" >> /etc/rsyncd.conf
systemctl enable --now rsyncd.service

# Add repository to pacman.conf
if aurhelper=$(pacman -Qmq | grep -E 'yay|pikaur|paru|trizen') ; then
	echo "Add $aurhelper AUR helper to pacmans repos."
  echo "[homerepo-aur]
  Server = http://$server:8080/archlinux/\$arch/aur
  SigLevel = Never" >> /etc/pacman.conf
else
	echo "No AUR helper installed."
fi
echo "[homerepo]
Server = http://$server:8080/archlinux/\$arch" >> /etc/pacman.conf