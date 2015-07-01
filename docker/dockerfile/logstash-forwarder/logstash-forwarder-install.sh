#!/bin/bash

cd /root/logstash-forwarder
go build -o logstash-forwarder
bundle install
make deb
dpkg -i logstash-forwarder_0.4.0_amd64.deb