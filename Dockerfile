FROM golang:alpine AS build

WORKDIR /go/src/app

RUN mkdir -p /go/src/app/github.com/kahing/goofys/ && \
    mkdir -p /mnt/s3 

RUN apk update && apk add git
RUN cd /go/src/app/github.com/kahing/ && \
    git clone https://github.com/kahing/goofys.git && \
    cd /go/src/app/github.com/ && \
    go install github.com/Azure/azure-pipeline-go && \
    cd /go/src/app/github.com/kahing/goofys && \
    git submodule init && \
    git submodule update && \
    go install ./...

FROM alpine:latest

ENV UID=0
ENV GID=0
ENV FILEMOD=0664
ENV DIRMODE=0664
ENV ENDPOINT=https://storage.yandexcloud.net
ENV BUCKETNAME=goofys
ENV MOUNTPOINT=/mnt/s3
ENV CREDPOINT=/root/.aws/credentials/.pass
ENV HOME=/root
ENV S3FS_ARGS=''
ENV AWS_ACCESS_KEY_ID=
ENV AWS_SECRET_ACCESS_KEY=

VOLUME [ "/mnt/s3" ]

# 添加启动脚本
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

COPY --from=build /go/bin/goofys /bin/goofys

RUN apk add --no-cache fuse

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["-f", "--endpoint=${ENDPOINT}", "--uid=${UID}", "--gid=${GID}", "--file-mode=${FILEMOD}", "--dir-mode=${DIRMODE}", "${S3FS_ARGS}", "${BUCKETNAME}", "${MOUNTPOINT}"]
