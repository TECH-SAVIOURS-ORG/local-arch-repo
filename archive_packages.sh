#!/bin/bash

# Variables
arch=$(uname -m)
## Add your archive server ip and user (rsync auth user)
server="$(cat /etc/rsyncd.server)"
user="$(cat /etc/rsyncd.user)"

# Rsync daemon
rsync -chavzP --password-file=/etc/rsyncd.password --ignore-existing /var/cache/pacman/pkg/*pkg* rsync://$user@$server/archiverepo/archlinux/$arch
