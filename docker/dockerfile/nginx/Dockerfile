FROM ubuntu:14.04

ENV	INSTALL_HOME="/root" \
	NGINX_VERSION=1.8.0

ENV	NGINX_HOME="/usr/local/nginx"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y curl wget make git gcc git libpcre3 libpcre3-dev libssl-dev libperl-dev \
 && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
 && git clone https://github.com/vkholodkov/nginx-eval-module.git ${INSTALL_HOME}/nginx-eval-module \
 && tar xzvpf nginx-${NGINX_VERSION}.tar.gz -C ${INSTALL_HOME} \
 && rm nginx-${NGINX_VERSION}.tar.gz
 
COPY nginx-install.sh ${INSTALL_HOME}/

RUN ${INSTALL_HOME}/nginx-install.sh \
 && rm ${INSTALL_HOME}/nginx-install.sh \
 && wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx \
 && chmod 755 /etc/init.d/nginx \
 && ln -s /usr/local/nginx-1.8.0 /usr/local/nginx
 

WORKDIR ${NGINX_HOME}