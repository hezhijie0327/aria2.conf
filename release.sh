#!/bin/bash

# Current Version: 1.1.6

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && chmod 0777 ./aria2.conf/release.sh && bash ./aria2.conf/release.sh

## Function
# Get Trackerslist Data
function GetTrackerslistData() {
    excludelist_data=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/trackerslist_exclude_aria2.txt")
    trackerlist_data=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/trackerslist_tracker_aria2.txt")
}
# Get Transmission Info
function GetTransmissionInfo() {
    transmission_agent=$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{ print $2 }' | sed "s/\ //g;s/\"//g;s/\,//g")
    transmission_id_prefx=$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{ print $2 }' | sed "s/\ //g;s/\"//g;s/\,//g;s/\.//g")
}
# Generate aria2c Options
function Generatearia2cOptions() {
    aria2c_options=(
        "#all-proxy-passwd="
        "#all-proxy-user="
        "#all-proxy="
        "allow-overwrite=false"
        "allow-piece-length-change=false"
        "always-resume=true"
        "#async-dns-server="
        "#async-dns=true"
        "auto-file-renaming=true"
        "auto-save-interval=5"
        "bt-detach-seed-only=true"
        "bt-enable-hook-after-hash-check=true"
        "bt-enable-lpd=true"
        "bt-exclude-tracker=${excludelist_data}"
        "#bt-external-ip="
        "bt-force-encryption=true"
        "bt-hash-check-seed=true"
        "bt-load-saved-metadata=true"
        "#bt-lpd-interface="
        "bt-max-open-files=65536"
        "bt-max-peers=0"
        "bt-metadata-only=false"
        "bt-min-crypto-level=arc4"
        "bt-prioritize-piece=head,tail"
        "bt-remove-unselected-file=false"
        "bt-request-peer-speed-limit=4M"
        "bt-require-crypto=true"
        "bt-save-metadata=true"
        "bt-seed-unverified=false"
        "bt-stop-timeout=0"
        "bt-tracker-connect-timeout=5"
        "bt-tracker-interval=0"
        "bt-tracker-timeout=5"
        "bt-tracker=${trackerlist_data}"
        "#ca-certificate="
        "#certificate="
        "check-certificate=true"
        "check-integrity=true"
        "#checksum="
        "conditional-get=false"
        "conf-path=${aria2_dir}aria2.conf"
        "connect-timeout=5"
        "console-log-level=error"
        "content-disposition-default-utf8=true"
        "continue=true"
        "daemon=true"
        "deferred-input=false"
        "dht-entry-point6=dht.transmissionbt.com:6881"
        "dht-entry-point=dht.transmissionbt.com:6881"
        "dht-file-path6=${aria2_dir}aria2.dht6"
        "dht-file-path=${aria2_dir}aria2.dht"
        "#dht-listen-addr6="
        "dht-listen-port=6881"
        "dht-message-timeout=5"
        "dir=${aria2_dir}Downloads"
        "disable-ipv6=false"
        "disk-cache=256M"
        "download-result=full"
        "dry-run=false"
        "#dscp="
        "enable-color=true"
        "enable-dht6=true"
        "enable-dht=true"
        "enable-http-keep-alive=true"
        "enable-http-pipelining=true"
        "enable-mmap=false"
        "enable-peer-exchange=true"
        "enable-rpc=true"
        "event-poll=${event_poll}"
        "#help"
        "file-allocation=none"
        "follow-metalink=mem"
        "follow-torrent=mem"
        "force-save=true"
        "force-sequential=true"
        "ftp-passwd=TRANSMISSIONUSER@"
        "ftp-pasv=true"
        "#ftp-proxy-passwd="
        "#ftp-proxy-user="
        "#ftp-proxy="
        "ftp-reuse-connection=true"
        "ftp-type=binary"
        "ftp-user=anonymous"
        "#gid="
        "hash-check-only=false"
        "#header="
        "http-accept-gzip=true"
        "http-auth-challenge=true"
        "http-no-cache=true"
        "#http-passwd="
        "#http-proxy-passwd="
        "#http-proxy-user="
        "#http-proxy="
        "#http-user="
        "#https-proxy-passwd="
        "#https-proxy-user="
        "#https-proxy="
        "human-readable=true"
        "#index-out="
        "input-file=${aria2_dir}aria2.session"
        "#interface="
        "keep-unfinished-download-result=true"
        "listen-port=51413"
        "load-cookies=${aria2_dir}aria2.cookie"
        "log-level=error"
        "log=${aria2_dir}aria2.log"
        "lowest-speed-limit=0"
        "max-concurrent-downloads=10"
        "max-connection-per-server=16"
        "max-download-limit=0"
        "max-download-result=10"
        "max-file-not-found=0"
        "#max-mmap-limit="
        "max-overall-download-limit=0"
        "max-overall-upload-limit=0"
        "max-resume-failure-tries=0"
        "max-tries=0"
        "max-upload-limit=0"
        "#metalink-base-uri="
        "metalink-enable-unique-protocol=false"
        "#metalink-file="
        "#metalink-language="
        "#metalink-location="
        "#metalink-os="
        "metalink-preferred-protocol=none"
        "#metalink-version="
        "min-split-size=4M"
        "min-tls-version=TLSv1.2"
        "#multiple-interface="
        "netrc-path=${aria2_dir}aria2.netrc"
        "no-conf=false"
        "no-file-allocation-limit=4M"
        "no-netrc=false"
        "#no-proxy="
        "#on-bt-download-complete="
        "#on-download-complete="
        "#on-download-error="
        "#on-download-pause="
        "#on-download-start="
        "#on-download-stop="
        "optimize-concurrent-downloads=true"
        "#out="
        "parameterized-uri=true"
        "pause-metadata=false"
        "pause=false"
        "peer-agent=Transmission/${transmission_agent}"
        "peer-id-prefix=-TR${transmission_id_prefx}0-"
        "piece-length=4M"
        "#private-key="
        "proxy-method=get"
        "quiet=false"
        "realtime-chunk-checksum=true"
        "referer=*"
        "remote-time=true"
        "remove-control-file=true"
        "retry-wait=0"
        "reuse-uri=true"
        "#rlimit-nofile="
        "rpc-allow-origin-all=true"
        "#rpc-certificate="
        "rpc-listen-all=true"
        "rpc-listen-port=6800"
        "rpc-max-request-size=4M"
        "#rpc-passwd="
        "#rpc-private-key="
        "rpc-save-upload-metadata=true"
        "#rpc-secret="
        "rpc-secure=false"
        "#rpc-user="
        "save-cookies=${aria2_dir}aria2.cookie"
        "save-not-found=true"
        "save-session-interval=5"
        "save-session=${aria2_dir}aria2.session"
        "seed-ratio=1.0"
        "seed-time=60"
        "#select-file="
        "server-stat-if=${aria2_dir}aria2.stat"
        "server-stat-of=${aria2_dir}aria2.stat"
        "server-stat-timeout=3600"
        "show-console-readout=true"
        "show-files=true"
        "socket-recv-buffer-size=0"
        "split=16"
        "#ssh-host-key-md="
        "stderr=true"
        "#stop-with-process="
        "stop=0"
        "stream-piece-selector=random"
        "summary-interval=5"
        "timeout=5"
        "#torrent-file="
        "truncate-console-readout=true"
        "uri-selector=adaptive"
        "use-head=true"
        "user-agent=Transmission/${transmission_agent}"
        "#version"
    )
}
# Output Data
function OutputData() {
    rm -rf ./aria2_*.conf
    for (( os_task = 0; os_task < 3; os_task++ )); do
        case ${os_task} in
            0)
            aria2_dir="/etc/aria2/" && event_poll="epoll" && Generatearia2cOptions
            for aria2c_options_task in "${!aria2c_options[@]}"; do
                echo "${aria2c_options[$aria2c_options_task]}" >> ./aria2_linux.conf
            done
            ;;
            1)
            aria2_dir="/etc/aria2/" && event_poll="kqueue" && Generatearia2cOptions
            for aria2c_options_task in "${!aria2c_options[@]}"; do
                echo "${aria2c_options[$aria2c_options_task]}" >> ./aria2_macos.conf
            done
            ;;
            2)
            aria2_dir="C:\Program Files\\aria2\\" && event_poll="select" && Generatearia2cOptions
            for aria2c_options_task in "${!aria2c_options[@]}"; do
                echo "${aria2c_options[$aria2c_options_task]}" >> ./aria2_windows.conf
            done
            ;;
        esac
    done
    exit 0
}

## Process
# Call GetTrackerslistData
GetTrackerslistData
# Call GetTransmissionInfo
GetTransmissionInfo
# Call OutputData
OutputData
