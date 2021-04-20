FROM golang:latest

ENV UID=10000
ENV GID=10000
ENV FILEMOD=0777
ENV DIRMODE=0777
ENV ENDPOINT=https://storage.yandexcloud.net
ENV BACKETNAME=BACKETNAME
ENV MOUNTPOINT=/mnt/s3

ENV CREDPOINT=/root/.aws/credentials

WORKDIR /go/src/app

RUN mkdir -p /go/src/app/github.com/kahing/goofys/ && \
    mkdir -p /mnt/s3 && \
    export GOOFYS_HOME=/go/src/app/github.com/kahing/goofys/

RUN cd /go/src/app/github.com/kahing/ && \
    git clone https://github.com/kahing/goofys.git

RUN cd /go/src/app/github.com/ && \
    go get github.com/Azure/azure-pipeline-go

RUN cd /go/src/app/github.com/kahing/goofys && \
    git submodule init && \
    git submodule update && \
    go install /go/src/app/github.com/kahing/goofys

RUN go version && goofys --version
# CMD ["app"]