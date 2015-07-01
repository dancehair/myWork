FROM ubuntu:14.04

ENV	INSTALL_HOME="/root" \
	LOGSTASH_VERSION=1.4.2

ENV	LOGSTASH_HOME="${INSTALL_HOME}/logstash-${LOGSTASH_VERSION}" \


RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget openjdk-7-jdk golang make git ruby-dev \
 && curl -O https://download.elasticsearch.org/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz \
 && tar xzvf logstash-${LOGSTASH_VERSION}.tar.gz -C ${INSTALL_HOME} \
 && rm logstash-${LOGSTASH_VERSION}.tar.gz \
 
COPY logstash.conf ${LOGSTASH_HOME}

WORKDIR ${LOGSTASH_HOME}