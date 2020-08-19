#!/bin/bash

# Current Version: 1.0.1

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && chmod 0777 ./aria2.conf/aria2.sh && bash ./aria2.conf/aria2.sh

aria2c_pid=$(ps -ef | grep "aria2c" | grep -v "grep" | awk '{ print $2 }')

if [ "${aria2c_pid}" == "" ]; then
    if [ ! -f "/etc/aria2/aria2.session" ]; then
        touch /etc/aria2/aria2.session
    fi
    aria2c --conf-path=/etc/aria2/aria2.conf
    exit 0
else
    kill ${aria2c_pid}
    exit 0
fi
