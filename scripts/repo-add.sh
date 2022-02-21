#!/bin/bash
# Used for `2.archive_packages-SERVER.hook` and rsync daemon `post-xfer exec = /root/repo-add.sh`

# aarch64
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.gz

# armv7h
repo-add --new /srv/http/repo/archlinux/armv7h/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7h/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/armv7h/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7h/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/armv7h/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7h/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/armv7h/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7h/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/armv7h/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7h/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/armv7h/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7h/aur/*pkg.tar.gz

# x86_64
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.gz