# local-arch-repo
Running multiple Arch devices? Create your own package archive repository and simply add another device.  
This is actually for a pinephone and other x86_64 Arch devices. Probably PIs (armv7l) will follow.

# Usage

## Packages
```
sudo pacman -S rsync
```

## Webserver

### Nginx
Add this to you webserver.
```
server {
        listen 8080;
        server_name SERVER_IP;

        location / {
                root /srv/http/repo/;
                autoindex         on;
        }
}
```

### python
```
cd /srv/http/repo/
python -m http.server
```

### darkhttpd
```
pacman -S darkhttpd
sudo -u http darkhttpd /srv/http/repo/ --no-server-id
```

## (Optional) Crontab -e
Packages older than half a year will be deleted.
```
@monthly find /srv/http/repo/* -mtime +182.5 '!' -regex '*pkg*' -exec rm {} \;
```

## Server & client
```
git clone https://github.com/TECH-SAVIOURS-ORG/local-arch-repo.git
cd local-arch-repo
chmod u+x start.sh
sudo ./start.sh
```

## Test it
```
/root/archive_packages.sh
```