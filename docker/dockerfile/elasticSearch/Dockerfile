FROM ubuntu:14.04

ENV	INSTALL_HOME="/root" \
	ELASTICSEARCH_VERSION=1.5.1

ENV	ELASTICSEARCH_HOME="${INSTALL_HOME}/elasticsearch-${ELASTICSEARCH_VERSION}" \
	ELASTICSEARCH_DATA_DIR="${ELASTICSEARCH_HOME}/data" \
	ELASTICSEARCH_LOG_DIR="${ELASTICSEARCH_HOME}/log" \
	ELASTICSEARCH_CONFIG_DIR="${ELASTICSEARCH_HOME}/config"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget openjdk-7-jdk golang make git ruby-dev \
 && curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
 && tar xzvf elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz -C ${INSTALL_HOME} \
 && rm elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz \
 && echo "${ELASTICSEARCH_HOME}/bin/elasticsearch -d -p es.pid" > ${ELASTICSEARCH_HOME}/start.sh \
 && echo "kill \`cat es.pid\`" > ${ELASTICSEARCH_HOME}/stop.sh \
 && chmod 755 ${ELASTICSEARCH_HOME}/start.sh ${ELASTICSEARCH_HOME}/stop.sh

COPY logging.yml ${ELASTICSEARCH_HOME}/config/ 


VOLUME ["${ELASTICSEARCH_DATA_DIR}", "${ELASTICSEARCH_LOG_DIR}", "${ELASTICSEARCH_CONFIG_DIR}"]
WORKDIR ${ELASTICSEARCH_HOME}