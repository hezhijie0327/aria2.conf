#!/bin/bash

# Current Version: 1.0.6

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && chmod 0777 ./aria2.conf/aria2.sh && bash ./aria2.conf/aria2.sh

aria2c_pid=$(ps -ef | grep "aria2c" | grep -v "grep" | awk '{ print $2 }')

if [ "${aria2c_pid}" == "" ]; then
    if [ ! -d "/etc/aria2" ]; then
        mkdir "/etc/aria2"
    fi
    if [ ! -d "/etc/aria2/cert" ]; then
        mkdir "/etc/aria2/cert"
    fi
    if [ ! -d "/etc/aria2/conf" ]; then
        mkdir "/etc/aria2/conf"
    fi
    if [ ! -d "/etc/aria2/data" ]; then
        mkdir "/etc/aria2/data"
    fi
    if [ ! -d "/etc/aria2/work" ]; then
        mkdir "/etc/aria2/work"
    fi
    if [ ! -f "/etc/aria2/conf/aria2.conf" ]; then
        curl --connect-timeout 15 "https://source.zhijie.online/aria2.conf/master/aria2_qb_linux.conf" > "/etc/aria2/conf/aria2.conf"
    fi
    if [ ! -f "/etc/aria2/work/aria2.cookie" ]; then
        touch "/etc/aria2/work/aria2.cookie"
    fi
    if [ ! -f "/etc/aria2/work/aria2.dht" ]; then
        touch "/etc/aria2/work/aria2.dht"
    fi
    if [ ! -f "/etc/aria2/work/aria2.dht6" ]; then
        touch "/etc/aria2/work/aria2.dht6"
    fi
    if [ ! -f "/etc/aria2/work/aria2.log" ]; then
        touch "/etc/aria2/work/aria2.log"
    fi
    if [ ! -f "/etc/aria2/work/aria2.netrc" ]; then
        touch "/etc/aria2/work/aria2.netrc"
    fi
    if [ ! -f "/etc/aria2/work/aria2.session" ]; then
        touch "/etc/aria2/work/aria2.session"
    fi
    if [ ! -f "/etc/aria2/work/aria2.stat" ]; then
        touch "/etc/aria2/work/aria2.stat"
    fi
    aria2c --conf-path="/etc/aria2/conf/aria2.conf"
    exit 0
else
    kill ${aria2c_pid}
    exit 0
fi
