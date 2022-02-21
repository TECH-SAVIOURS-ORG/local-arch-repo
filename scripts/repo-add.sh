#!/bin/bash
# Used for `2.archive_packages-SERVER.hook` and rsync daemon `post-xfer exec = /root/repo-add.sh`

# aarch64
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/aarch64/homerepo.db.tar.zst /srv/http/repo/archlinux/aarch64/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/aarch64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/aarch64/aur/*pkg.tar.gz

# armv7l
repo-add --new /srv/http/repo/archlinux/armv7l/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7l/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/armv7l/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7l/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/armv7l/homerepo.db.tar.zst /srv/http/repo/archlinux/armv7l/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/armv7l/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7l/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/armv7l/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7l/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/armv7l/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/armv7l/aur/*pkg.tar.gz

# x86_64
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/x86_64/homerepo.db.tar.zst /srv/http/repo/archlinux/x86_64/*pkg.tar.gz
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.xz
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.zst
repo-add --new /srv/http/repo/archlinux/x86_64/aur/homerepo-aur.db.tar.zst /srv/http/repo/archlinux/x86_64/aur/*pkg.tar.gz