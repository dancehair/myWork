#!/bin/bash

cd ~/memcached-1.2.8-repcached-2.2.1
./configure --enable-replication
sed -i -e '59d' -e '57d' memcached.c
make
make install