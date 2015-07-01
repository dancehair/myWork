FROM ubuntu:14.04

ENV	INSTALL_HOME="/root" \
	MEMCACHED_VERSION=1.2.8 \
	REPCACHED_VERSION=2.2.1

ENV	MEMCACHE_HOME="${INSTALL_HOME}/memcached-${MEMCACHED_VERSION}-repcached-${REPCACHED_VERSION}

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget openjdk-7-jdk make git libevent-dev g++ \
 && wget http://jaist.dl.sourceforge.net/project/repcached/repcached/${REPCACHED_VERSION}-${MEMCACHED_VERSION}/memcached-${MEMCACHED_VERSION}-repcached-${REPCACHED_VERSION}.tar.gz \
 && tar xzvpf memcached-${MEMCACHED_VERSION}-repcached-${REPCACHED_VERSION}.tar.gz -C ${INSTALL_HOME} \
 && rm memcached-${MEMCACHED_VERSION}-repcached-${REPCACHED_VERSION}.tar.gz
 
COPY memcached-install.sh ${INSTALL_HOME}/
COPY memcachedrep /etc/init.d/

RUN ${INSTALL_HOME}/memcached-install.sh \
 && rm ${INSTALL_HOME}/memcached-install.sh

WORKDIR ${INSTALL_HOME}