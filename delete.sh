#!/bin/bash
# Delete everything
read -r -p "You are going to delete everything. Are you sure? [YES/no] " prompt

if [[ $prompt == "YES" ]]
then

arch=$(uname -m)

# Hooks
rm /etc/pacman.d/hooks/1.cleanup_cache.hook
rm /etc/pacman.d/hooks/2.archive_packages.hook

# scripts
rm /root/repo-add.sh
rm /root/archive_packages.sh

# Repo
rm -r /srv/http/repo/

# Pacman config
sed -i "s|CacheDir    = /srv/http/repo/archlinux/$arch/|#CacheDir    = /var/cache/pacman/pkg/|g" /etc/pacman.conf
head -n -2 /etc/pacman.conf > tmp.txt && mv tmp.txt /etc/pacman.conf

# Rsync
rm /etc/rsyncd.secrets
rm /etc/rsyncd.user
rm /etc/rsyncd.password
rm /etc/rsyncd.server

else

echo "Nothing has been deleted."

fi