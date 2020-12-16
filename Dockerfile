FROM alpine:3.12
LABEL maintainer="James <james.ietf@gmail.com>"

RUN sed -i '/edge/s/^#//' /etc/apk/repositories
RUN apk -U upgrade
RUN apk add rsync

COPY bin/ /usr/local/bin/
