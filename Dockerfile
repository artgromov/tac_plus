FROM ubuntu

LABEL maintainer="Artem Gromov <artyomgromov@gmail.com>" version="0.5.1"

ARG url=http://www.pro-bono-publico.de/projects/src/DEVEL.201710201114.tar.bz2

ENV conf=/usr/local/etc/tac_plus.conf

RUN apt-get update -y \
&& apt-get install -y \
apt-utils \
libbind-dev \
libpcre3-dev \
libssl-dev \
libcurl4-openssl-dev \
build-essential \
wget \
bzip2 \
libnet-ldap-perl \
iproute2 \
iputils-ping \
inetutils-traceroute \
tcpdump \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir /build && wget $url -O /build/${url##*/} && tar -xf /build/${url##*/} -C /build/

WORKDIR /build/PROJECTS

RUN ./configure \
--prefix=/usr \
--bindir=/usr/bin \
--etcdir=/etc \
--sbindir=/usr/sbin \
--libdir=/usr/lib \
--libarchdir=/usr/lib64 \
--libexecdir=/usr/libexec \
--docdir=/usr/share/mavis \
--with-epoll \
--with-lwres \
--with-pcre \
--with-ssl \
--with-curl \
mavis spawnd tac_plus

RUN make && make install

RUN ln -s /usr/lib/mavis /usr/local/lib/mavis

WORKDIR /

RUN apt-get remove -y \
libbind-dev \
libpcre3-dev \
libssl-dev \
libcurl4-openssl-dev \
build-essential \
wget \
bzip2 \
&& apt-get clean \
&& rm -rf /build

EXPOSE 49

CMD tac_plus -f ${conf}
