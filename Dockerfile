FROM alpine:3.4
MAINTAINER Stephen Hellicar

ENV VERSION=v1.18.1.5 \
    URL=https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/${VERSION}/s6-overlay-amd64.tar.gz

# add s6-overlay
RUN apk add --no-cache curl \
&&  curl -sSL ${URL} > /tmp/down.tar.gz \
&&  tar xfz /tmp/down.tar.gz -C / \
&&  apk del -r curl \
# add packages
&&  apk add openssh docker py-pip bash sudo --no-cache

# gen keys
RUN ssh-keygen -A \
&&  rm -rf /tmp/*

ADD ./services.d /etc/services.d
ADD ./docker-enter /usr/local/bin
ADD ./authorized_keys /root/.ssh/

RUN chmod 700 /root/.ssh \
&&  chmod 600 /root/.ssh/authorized_keys \
&&  chown -R root:root /root/.ssh

EXPOSE 22

ENTRYPOINT ["/init"]
CMD []

