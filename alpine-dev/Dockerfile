FROM alpine:latest

LABEL maintainer="Stephen Hellicar <s.hellicar@gmail.com>"

ENV S6_VERSION=v1.20.0.0
ENV S6_URL="https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64.tar.gz"
ENV COMPOSE_VERSION=1.16.1
ENV COMPOSE_URL="https://github.com/docker/compose/release/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64"

RUN echo S6_URL=${S6_URL} >/dev/stderr
RUN echo COMPOSE_URL=${COMPOSE_URL} >/dev/stderr

# add s6-overlay
RUN apk add --no-cache curl \
&&  curl -sSL ${S6_URL} > /tmp/down.tar.gz \
&&  curl -L "${COMPOSE_URL}" -o /usr/local/bin/docker-compose \
&&  chmod +x /usr/local/bin/docker-compose \
&&  tar xfz /tmp/down.tar.gz -C / \
&&  apk del -r curl


ENV PACKAGES="openssh docker bash sudo vim openssl git less"

# add packages
RUN apk add ${PACKAGES} --no-cache

RUN apk add tzdata --no-cache \
&&  cp /usr/share/zoneinfo/Australia/Hobart /etc/localtime \
&&  apk del -r tzdata

# gen keys
RUN ssh-keygen -A

ADD ./services.d /etc/services.d
ADD ./bin/docker-enter /usr/local/bin

VOLUME /home


WORKDIR /tmp/
ADD ./tmp/ .
ADD replace.sh .
RUN ./replace.sh

RUN apk add shadow --no-cache

ADD adddocker.sh .
RUN ./adddocker.sh


EXPOSE 22

ENTRYPOINT ["/init"]
CMD []

RUN rm -rf /tmp/*

