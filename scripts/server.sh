#!/bin/bash
# Variables
arch=$(uname -m)
server="$(ip addr show | grep "inet " | grep -v 127.0.0. | head -1 | cut -d" " -f6 | cut -d/ -f1)"
## Rsync credentials
read -p "Enter your user for rsync daemon credentials: " user
read -p "Enter your password: " -s password

# Hooks
mkdir /etc/pacman.d/hooks/
cp hooks/1.cleanup_cache.hook /etc/pacman.d/hooks/
cp hooks/2.archive_packages-server.hook /etc/pacman.d/hooks/2.archive_packages.hook

# Script/s
cp scripts/repo-add.sh /root/
chmod +x /root/repo-add.sh

# Database
mkdir -p /srv/http/repo/archlinux/{x86_64,aarch64}/AUR
repo-add /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst
repo-add /srv/http/repo/archlinux/x86_64/AUR/homerepo.db.tar.zst
repo-add /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst
repo-add /srv/http/repo/archlinux/aarch64/AUR/homerepo.db.tar.zst

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
echo "[homerepo]
Server = http://$server:8080/archlinux/\$arch" >> /etc/pacman.conf