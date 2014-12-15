# dokuwiki-docker

## Usage
Create & tag image:
```
docker build -t nuada/dokuwiki .
docker tag nuada/dokuwiki:latest nuada/dokuwiki:$(date +%F)
```

Create wiki container:
```
docker run -d --name dokuwiki -p 8080:80 nuada/dokuwiki
```

To create backup Dokuwiki data use new container:
```
docker run -i -t --rm --volumes-from dokuwiki -v $(pwd):/host ubuntu tar cz -C /var/www/data -f /host/dokuwiki-$(date +%F).tgz .
```

To restore from backup:
```
docker run -i -t --rm --volumes-from dokuwiki -v $(pwd):/host nuada/dokuwiki restore-from-backup.sh /host/<backup_file>.tgz
```
