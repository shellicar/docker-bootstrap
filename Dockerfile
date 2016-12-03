FROM alpine:3.4
MAINTAINER Stephen Hellicar

ENV VERSION=v1.18.1.5 \
    URL=https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/${VERSION}/s6-overlay-amd64.tar.gz

# add s6-overlay
RUN apk add --no-cache curl \
&&  curl -sSL ${URL} > /tmp/down.tar.gz \
&&  tar xfz /tmp/down.tar.gz -C / \
&&  apk del -r curl

# add packages
RUN apk add openssh docker py-pip bash sudo --no-cache

RUN apk add tzdata --no-cache \
&&  cp /usr/share/zoneinfo/Australia/Melbourne /etc/localtime \
&&  apk del -r tzdata

# gen keys
RUN ssh-keygen -A

RUN apk add python --no-cache \
&&  pip install --upgrade pip \
&&  pip install docker-compose


ADD ./services.d /etc/services.d
ADD ./bin/docker-enter /usr/local/bin


VOLUME /home


EXPOSE 22

ENTRYPOINT ["/init"]
CMD []

RUN rm -rf /tmp/*

