#!/bin/bash

# Current Version: 1.0.0

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && chmod 0777 ./aria2.conf/release.sh && bash ./aria2.conf/release.sh

## Function
# Advanced Options
function Advanced_Options() {
    echo "## Advanced Options" >> ./${Branch}
    echo "allow-overwrite=true" >> ./${Branch}
    echo "allow-piece-length-change=true" >> ./${Branch}
    echo "always-resume=true" >> ./${Branch}
    echo "#async-dns-server=" >> ./${Branch}
    echo "async-dns=true" >> ./${Branch}
    echo "auto-file-renaming=true" >> ./${Branch}
    echo "auto-save-interval=5" >> ./${Branch}
    echo "conditional-get=false" >> ./${Branch}
    echo "conf-path=/etc/aria2/aria2.conf" >> ./${Branch}
    echo "console-log-level=error" >> ./${Branch}
    echo "content-disposition-default-utf8=true" >> ./${Branch}
    echo "daemon=true" >> ./${Branch}
    echo "deferred-input=false" >> ./${Branch}
    echo "disable-ipv6=false" >> ./${Branch}
    echo "disk-cache=64M" >> ./${Branch}
    echo "download-result=full" >> ./${Branch}
    echo "#dscp=" >> ./${Branch}
    echo "enable-color=true" >> ./${Branch}
    echo "enable-mmap=true" >> ./${Branch}
    echo "event-poll=epoll" >> ./${Branch}
    echo "file-allocation=falloc" >> ./${Branch}
    echo "force-save=true" >> ./${Branch}
    echo "force-sequential=false" >> ./${Branch}
    echo "#gid=" >> ./${Branch}
    echo "hash-check-only=false" >> ./${Branch}
    echo "human-readable=true" >> ./${Branch}
    echo "#interface=" >> ./${Branch}
    echo "keep-unfinished-download-result=true" >> ./${Branch}
    echo "log-level=error" >> ./${Branch}
    echo "max-download-limit=0" >> ./${Branch}
    echo "max-download-result=64" >> ./${Branch}
    echo "max-mmap-limit=9223372036854775807" >> ./${Branch}
    echo "max-overall-download-limit=0" >> ./${Branch}
    echo "max-resume-failure-tries=5" >> ./${Branch}
    echo "min-tls-version=TLSv1.2" >> ./${Branch}
    echo "#multiple-interface=" >> ./${Branch}
    echo "no-conf=false" >> ./${Branch}
    echo "no-file-allocation-limit=64M" >> ./${Branch}
    echo "#on-bt-download-complete=" >> ./${Branch}
    echo "#on-download-complete=" >> ./${Branch}
    echo "#on-download-error=" >> ./${Branch}
    echo "#on-download-pause=" >> ./${Branch}
    echo "#on-download-start=" >> ./${Branch}
    echo "#on-download-stop=" >> ./${Branch}
    echo "optimize-concurrent-downloads=true" >> ./${Branch}
    echo "parameterized-uri=true" >> ./${Branch}
    echo "piece-length=64M" >> ./${Branch}
    echo "quiet=true" >> ./${Branch}
    echo "realtime-chunk-checksum=true" >> ./${Branch}
    echo "remove-control-file=true" >> ./${Branch}
    echo "rlimit-nofile=65536" >> ./${Branch}
    echo "save-not-found=true" >> ./${Branch}
    echo "save-session-interval=5" >> ./${Branch}
    echo "save-session=/etc/aria2/aria2.session" >> ./${Branch}
    echo "show-console-readout=true" >> ./${Branch}
    echo "socket-recv-buffer-size=0" >> ./${Branch}
    echo "stderr=false" >> ./${Branch}
    echo "#stop-with-process=" >> ./${Branch}
    echo "stop=0" >> ./${Branch}
    echo "summary-interval=5" >> ./${Branch}
    echo "truncate-console-readout=true" >> ./${Branch}
    echo "" >> ./${Branch}
}
# Basic Options
function Basic_Options() {
    echo "## Basic Options" >> ./${Branch}
    echo "check-integrity=true" >> ./${Branch}
    echo "continue=true" >> ./${Branch}
    echo "dir=/mnt/md0/Downloads" >> ./${Branch}
    echo "input-file=/etc/aria2/aria2.session" >> ./${Branch}
    echo "log=/etc/aria2/aria2.log" >> ./${Branch}
    echo "max-concurrent-downloads=10" >> ./${Branch}
    echo "" >> ./${Branch}
}
# BitTorrent / Metalink Options
function BitTorrent_Metalink_Options() {
    echo "## BitTorrent / Metalink Options" >> ./${Branch}
    echo "#select-file=" >> ./${Branch}
    echo "show-files=false" >> ./${Branch}
    echo "" >> ./${Branch}
}
# HTTP / FTP / SFTP Options
function HTTP_FTP_SFTP_Options() {
    echo "## HTTP / FTP / SFTP Options" >> ./${Branch}
    echo "#all-proxy-passwd=" >> ./${Branch}
    echo "#all-proxy-user=" >> ./${Branch}
    echo "#all-proxy=" >> ./${Branch}
    echo "#checksum=" >> ./${Branch}
    echo "connect-timeout=5" >> ./${Branch}
    echo "dry-run=false" >> ./${Branch}
    echo "lowest-speed-limit=0" >> ./${Branch}
    echo "max-connection-per-server=16" >> ./${Branch}
    echo "max-file-not-found=5" >> ./${Branch}
    echo "max-tries=5" >> ./${Branch}
    echo "min-split-size=64M" >> ./${Branch}
    echo "netrc-path=/etc/aria2/aria2.netrc" >> ./${Branch}
    echo "no-netrc=false" >> ./${Branch}
    echo "#no-proxy=" >> ./${Branch}
    echo "#out=" >> ./${Branch}
    echo "proxy-method=get" >> ./${Branch}
    echo "remote-time=true" >> ./${Branch}
    echo "retry-wait=5" >> ./${Branch}
    echo "reuse-uri=true" >> ./${Branch}
    echo "server-stat-if=/etc/aria2/aria2.stat" >> ./${Branch}
    echo "server-stat-of=/etc/aria2/aria2.stat" >> ./${Branch}
    echo "server-stat-timeout=3600" >> ./${Branch}
    echo "split=16" >> ./${Branch}
    echo "stream-piece-selector=random" >> ./${Branch}
    echo "timeout=5" >> ./${Branch}
    echo "uri-selector=adaptive" >> ./${Branch}
    echo "" >> ./${Branch}
}
# BitTorrent Specific Options
function BitTorrent_Specific_Options() {
    echo "## BitTorrent Specific Options" >> ./${Branch}
    echo "bt-detach-seed-only=true" >> ./${Branch}
    echo "bt-enable-hook-after-hash-check=true" >> ./${Branch}
    echo "bt-enable-lpd=true" >> ./${Branch}
    echo "bt-exclude-tracker=$(curl -s --connect-timeout 15 ${Excludelist})" >> ./${Branch}
    echo "#bt-external-ip=" >> ./${Branch}
    echo "bt-force-encryption=true" >> ./${Branch}
    echo "bt-hash-check-seed=true" >> ./${Branch}
    echo "bt-load-saved-metadata=true" >> ./${Branch}
    echo "#bt-lpd-interface=" >> ./${Branch}
    echo "bt-max-open-files=65536" >> ./${Branch}
    echo "bt-max-peers=0" >> ./${Branch}
    echo "bt-metadata-only=false" >> ./${Branch}
    echo "bt-min-crypto-level=arc4" >> ./${Branch}
    echo "#bt-prioritize-piece=" >> ./${Branch}
    echo "bt-remove-unselected-file=true" >> ./${Branch}
    echo "bt-request-peer-speed-limit=4M" >> ./${Branch}
    echo "bt-require-crypto=true" >> ./${Branch}
    echo "bt-save-metadata=true" >> ./${Branch}
    echo "bt-seed-unverified=false" >> ./${Branch}
    echo "bt-stop-timeout=0" >> ./${Branch}
    echo "bt-tracker-connect-timeout=5" >> ./${Branch}
    echo "bt-tracker-interval=0" >> ./${Branch}
    echo "bt-tracker-timeout=5" >> ./${Branch}
    echo "bt-tracker=$(curl -s --connect-timeout 15 ${Trackerlist})" >> ./${Branch}
    echo "dht-entry-point6=dht.transmissionbt.com:6881" >> ./${Branch}
    echo "dht-entry-point=dht.transmissionbt.com:6881" >> ./${Branch}
    echo "dht-file-path6=/etc/aria2/aria2.dht6" >> ./${Branch}
    echo "dht-file-path=/etc/aria2/aria2.dht" >> ./${Branch}
    echo "#dht-listen-addr6=" >> ./${Branch}
    echo "dht-listen-port=6881" >> ./${Branch}
    echo "dht-message-timeout=5" >> ./${Branch}
    echo "enable-dht6=true" >> ./${Branch}
    echo "enable-dht=true" >> ./${Branch}
    echo "enable-peer-exchange=true" >> ./${Branch}
    echo "follow-torrent=true" >> ./${Branch}
    echo "#index-out=" >> ./${Branch}
    echo "listen-port=51413" >> ./${Branch}
    echo "max-overall-upload-limit=0" >> ./${Branch}
    echo "max-upload-limit=0" >> ./${Branch}
    echo "peer-agent=Transmission/$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed "s/\ //g;s/\"//g;s/\,//g")" >> ./${Branch}
    echo "peer-id-prefix=-TR$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed "s/\ //g;s/\"//g;s/\,//g;s/\.//g")0-" >> ./${Branch}
    echo "seed-ratio=1.0" >> ./${Branch}
    echo "seed-time=60" >> ./${Branch}
    echo "" >> ./${Branch}
}
# FTP / SFTP Specific Options
function FTP_SFTP_Specific_Options() {
    echo "## FTP / SFTP Specific Options" >> ./${Branch}
    echo "ftp-passwd=TRANSMISSIONUSER@" >> ./${Branch}
    echo "ftp-pasv=true" >> ./${Branch}
    echo "#ftp-proxy-passwd=" >> ./${Branch}
    echo "#ftp-proxy-user=" >> ./${Branch}
    echo "#ftp-proxy=" >> ./${Branch}
    echo "ftp-reuse-connection=true" >> ./${Branch}
    echo "ftp-type=binary" >> ./${Branch}
    echo "ftp-user=anonymous" >> ./${Branch}
    echo "#ssh-host-key-md=" >> ./${Branch}
    echo "" >> ./${Branch}
}
# HTTP Specific Options
function HTTP_Specific_Options() {
    echo "## HTTP Specific Options" >> ./${Branch}
    echo "#ca-certificate=" >> ./${Branch}
    echo "#certificate=" >> ./${Branch}
    echo "check-certificate=true" >> ./${Branch}
    echo "enable-http-keep-alive=true" >> ./${Branch}
    echo "enable-http-pipelining=true" >> ./${Branch}
    echo "#header=" >> ./${Branch}
    echo "http-accept-gzip=true" >> ./${Branch}
    echo "http-auth-challenge=true" >> ./${Branch}
    echo "http-no-cache=false" >> ./${Branch}
    echo "#http-passwd=" >> ./${Branch}
    echo "#http-proxy-passwd=" >> ./${Branch}
    echo "#http-proxy-user=" >> ./${Branch}
    echo "#http-proxy=" >> ./${Branch}
    echo "#http-user=" >> ./${Branch}
    echo "#https-proxy-passwd=" >> ./${Branch}
    echo "#https-proxy-user=" >> ./${Branch}
    echo "#https-proxy=" >> ./${Branch}
    echo "load-cookies=/etc/aria2/aria2.cookies" >> ./${Branch}
    echo "#private-key=" >> ./${Branch}
    echo "#referer=" >> ./${Branch}
    echo "save-cookies=/etc/aria2/aria2.cookies" >> ./${Branch}
    echo "use-head=true" >> ./${Branch}
    echo "user-agent=Transmission/$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed "s/\ //g;s/\"//g;s/\,//g")" >> ./${Branch}
    echo "" >> ./${Branch}
}
# Metalink Specific Options
function Metalink_Specific_Options() {
    echo "## Metalink Specific Options" >> ./${Branch}
    echo "follow-metalink=mem" >> ./${Branch}
    echo "#metalink-base-uri=" >> ./${Branch}
    echo "metalink-enable-unique-protocol=false" >> ./${Branch}
    echo "#metalink-file=" >> ./${Branch}
    echo "#metalink-language=" >> ./${Branch}
    echo "#metalink-location=" >> ./${Branch}
    echo "#metalink-os=" >> ./${Branch}
    echo "metalink-preferred-protocol=https" >> ./${Branch}
    echo "#metalink-version=" >> ./${Branch}
    echo "" >> ./${Branch}
}
# RPC Options
function RPC_Options() {
    echo "## RPC Options" >> ./${Branch}
    echo "enable-rpc=true" >> ./${Branch}
    echo "pause-metadata=false" >> ./${Branch}
    echo "pause=false" >> ./${Branch}
    echo "rpc-allow-origin-all=true" >> ./${Branch}
    echo "#rpc-certificate=" >> ./${Branch}
    echo "rpc-listen-all=true" >> ./${Branch}
    echo "rpc-listen-port=6800" >> ./${Branch}
    echo "rpc-max-request-size=64M" >> ./${Branch}
    echo "#rpc-private-key=" >> ./${Branch}
    echo "rpc-save-upload-metadata=true" >> ./${Branch}
    echo "#rpc-secret=" >> ./${Branch}
    echo "rpc-secure=false" >> ./${Branch}
    echo "" >> ./${Branch}
}
# Generate Configuration
function GenerateConfiguration() {
    echo "# /etc/aria2/aria2.conf Start" > ./${Branch}
    echo "" >> ./${Branch}
    Advanced_Options
    Basic_Options
    BitTorrent_Metalink_Options
    HTTP_FTP_SFTP_Options
    BitTorrent_Specific_Options
    FTP_SFTP_Specific_Options
    HTTP_Specific_Options
    Metalink_Specific_Options
    RPC_Options
    echo "# /etc/aria2/aria2.conf End" >> ./${Branch}
}

## Process
# Call GenerateConfiguration -> aria2.conf
Branch="aria2.conf"
Excludelist="https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/list_exclude_aria2.txt"
Trackerlist="https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/list_tracker_aria2.txt"
GenerateConfiguration
# Call GenerateConfiguration -> aria2_full.conf
Branch="aria2_full.conf"
Excludelist=" "
Trackerlist="https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/list_full_aria2.txt"
GenerateConfiguration
exit 0
