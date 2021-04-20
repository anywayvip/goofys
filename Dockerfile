FROM golang:alpine AS build

WORKDIR /go/src/app

RUN mkdir -p /go/src/app/github.com/kahing/goofys/ && \
    mkdir -p /mnt/s3 && \
    export GOOFYS_HOME=/go/src/app/github.com/kahing/goofys/
RUN apk update && apk add git
RUN cd /go/src/app/github.com/kahing/ && \
    git clone https://github.com/kahing/goofys.git && \
    cd /go/src/app/github.com/ && \
    go get github.com/Azure/azure-pipeline-go && \
    cd /go/src/app/github.com/kahing/goofys && \
    git submodule init && \
    git submodule update && \
    go install /go/src/app/github.com/kahing/goofys

FROM alpine:latest

ENV UID=0
ENV GID=0
ENV FILEMOD=0664
ENV DIRMODE=0664
ENV ENDPOINT=https://storage.yandexcloud.net
ENV BACKETNAME=goofys
ENV MOUNTPOINT=/mnt/s3
ENV CREDPOINT=/root/.aws/credentials
ENV HOME=/root
ENV S3FS_ARGS=''

VOLUME [ "/mnt/s3" ]

COPY --from=build /go/bin/goofys /bin/goofys
COPY --from=build /go/src/app/github.com/kahing/goofys /go/goofys
RUN apk add --no-cache fuse
RUN export GOOFYS_HOME=/go/src/app/github.com/kahing/goofys/ \
    && export HOME=${HOME}

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["/bin/goofys -f --endpoint=${ENDPOINT} --uid=${UID} --gid=${GID} --file-mode=${FILEMOD} --dir-mode=${DIRMODE} ${S3FS_ARGS} ${BACKETNAME} ${MOUNTPOINT}"]