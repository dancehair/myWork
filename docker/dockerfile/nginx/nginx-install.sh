#!/bin/bash

cd /root/nginx-1.8.0

./configure --prefix=/usr/local/nginx-1.8.0 --with-http_ssl_module --with-http_dav_module --with-perl_modules_path=/usr/lib/perl/5.10 --with-perl=/usr/bin/perl --with-http_perl_module --with-http_realip_module --with-debug --add-module=/root/nginx-eval-module --pid-path=/usr/local/nginx-1.8.0/logs/nginx.pid

sed -i s/\-Werror//g ./objs/Makefile
make
make install