FROM ubuntu:17.04

LABEL maintainer="Artem Gromov <artyomgromov@gmail.com>" version="0.5"

ARG url=http://www.pro-bono-publico.de/projects/src/DEVEL.201706241310.tar.bz2

ENV conf=/usr/local/etc/tac_plus.conf

RUN apt-get update -y \
&& apt-get install -y \
libbind-dev \
libpcre3-dev \
libssl-dev \
zlib1g-dev \
libcurl4-openssl-dev \
build-essential \
linux-headers-generic \
wget \
bzip2 \
libnet-ldap-perl \
iproute2 \
iputils-ping \
inetutils-traceroute \
tcpdump \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /build && wget $url -O /build/${url##*/} && tar -xf /build/${url##*/} -C /build/

RUN /build/PROJECTS/configure \
--with-epoll \
--with-lwres \
--with-pcre \
--with-ssl \
--with-zlib \
--with-curl \
mavis spawnd tac_plus

RUN make -C /build/PROJECTS && make -C /build/PROJECTS install

RUN apt-get remove -y \
libbind-dev \
libpcre3-dev \
libssl-dev \
zlib1g-dev \
libcurl4-openssl-dev \
build-essential \
linux-headers-generic \
wget \
bzip2 \
&& apt-get clean \
&& rm -rf /build

EXPOSE 49

CMD tac_plus -f ${conf}
