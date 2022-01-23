#!/bin/bash
# Used for `2.archive_packages-SERVER.hook` and rsync daemon `post-xfer exec = /root/repo-add.sh`
repo-add /srv/http/repo/archlinux/*/homerepo.db.tar.zst /srv/http/repo/archlinux/*/{*.zst,*.gz,*.xz}