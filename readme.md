# Goofys
## Goofys is a high-performance, POSIX-ish Amazon S3 file system written in Go


### /root/.aws/credentials

Create local file ```.pass```

```
[default]
aws_access_key_id = 
aws_secret_access_key = 
```


### Run

```
docker run --device=/dev/fuse \
--privileged \
-v .pass:/root/.aws/credentials \
-v <localmount>:/mnt/s3 \
gseldon/goofys
```

### Docker-compose ```docker-compose.yml```

```docker
version: '3.7'
services:
  s3fs:
    container_name: s3fs
    image: gseldon/goofys:latest
    restart: unless-stopped
    cap_add:
      - SYS_ADMIN
    security_opt:
      - 'apparmor:unconfined'
    devices:
      - /dev/fuse
    volumes:
      - /mnt/tmp:/mnt/s3:rshared
      - ./credentials:/root/.aws/credentials
    environment:
        ENDPOINT: https://storage.yandexcloud.net
        BACKETNAME: 
```



---
[Main Project](https://github.com/kahing/goofys)
[Install](https://github.com/kahing/goofys/issues/527#issuecomment-673909445)