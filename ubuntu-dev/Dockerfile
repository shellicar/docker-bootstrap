FROM phusion/baseimage
MAINTAINER Stephen Hellicar <s.hellicar@gmail.com>

RUN apt-get update && apt-get install -y \
	sudo \
	bash \
	vim \
	docker.io \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose



WORKDIR /tmp/
ADD ./tmp/ .
ADD replace.sh .
RUN ./replace.sh

VOLUME /home

EXPOSE 22

RUN rm -rf /tmp/*

