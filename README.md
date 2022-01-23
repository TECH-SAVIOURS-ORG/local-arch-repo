# local-arch-repo
Running multiple Arch devices? Create your own package archive repository and simply add another device.  
This is actually for a pinephone and other x86_64 Arch devices. Probably PIs (armv7l) will follow.  

# What does it?
These are just a few bash scripts to install your local repository or add another client, and two hooks for your pacman updates.  
  
On the _server_ side, the __rsync daemon__ + credentials + config file modifications are created to be ready for the clients. Furthermore, the __hooks__ are placed and also the `repo-add.sh` script for the `post exec` commands - after the client has pushed its packages or for the server after it has received an update via pacman (hook). The `pacman.conf` is modified for the new repository and the new package cache path.  
  
On the _client_ side, `pacman.conf` is also changed for the new repository. Like on the server, the hooks are placed and `archive_packages.sh` is copied to the root folder, which will be activated via the hook. Rsync credentials are created.

# Usage
Just run the `start.sh` script and chose either `SERVER` or `client`. 

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

BTW Pinephone + #keyboard test is coming in about 6 weeks. My daily phone is on vacation (warranty). So I will test it as a daily driver.