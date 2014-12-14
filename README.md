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
