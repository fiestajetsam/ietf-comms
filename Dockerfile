FROM alpine:3.12
LABEL maintainer="James <james.ietf@gmail.com>"

RUN sed -i '/edge/s/^#//' /etc/apk/repositories
RUN apk -U upgrade
RUN apk add rsync

RUN apk add \
        tmux \
        gdbm \
        -X https://dl-cdn.alpinelinux.org/alpine/edge/main

RUN apk add \
        msmtp \
        isync \
        -X https://dl-cdn.alpinelinux.org/alpine/edge/community

RUN apk add \
        neomutt \
        -X https://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY bin/ /usr/local/bin/

COPY bin/mail_sync /etc/periodic/15min/
