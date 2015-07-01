FROM ubuntu:14.04

ENV	INSTALL_HOME="/root"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget make git golang ruby-dev \
 && gem install bundler \
 && bundle install \
 && git clone git://github.com/elasticsearch/logstash-forwarder.git ${INSTALL_HOME}/logstash-forwarder
 
COPY logstash-forwarder-install.sh ${INSTALL_HOME}/

RUN ${INSTALL_HOME}/logstash-forwarder-install.sh \
 && rm ${INSTALL_HOME}/logstash-forwarder-install.sh

WORKDIR ${INSTALL_HOME}