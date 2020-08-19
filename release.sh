#!/bin/bash

# Current Version: 1.0.2

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && chmod 0777 ./aria2.conf/release.sh && bash ./aria2.conf/release.sh

## Function
# Generate Header
function GenerateHeader() {
    echo "# /etc/aria2/aria2.conf Start" > ./aria2.conf
    echo "" >> ./aria2.conf
}
# Advanced Options
function Advanced_Options() {
    echo "## Advanced Options" >> ./aria2.conf
    echo "allow-overwrite=true" >> ./aria2.conf
    echo "allow-piece-length-change=true" >> ./aria2.conf
    echo "always-resume=true" >> ./aria2.conf
    echo "#async-dns-server=" >> ./aria2.conf
    echo "async-dns=true" >> ./aria2.conf
    echo "auto-file-renaming=true" >> ./aria2.conf
    echo "auto-save-interval=5" >> ./aria2.conf
    echo "conditional-get=false" >> ./aria2.conf
    echo "conf-path=/etc/aria2/aria2.conf" >> ./aria2.conf
    echo "console-log-level=error" >> ./aria2.conf
    echo "content-disposition-default-utf8=true" >> ./aria2.conf
    echo "daemon=true" >> ./aria2.conf
    echo "deferred-input=false" >> ./aria2.conf
    echo "disable-ipv6=false" >> ./aria2.conf
    echo "disk-cache=64M" >> ./aria2.conf
    echo "download-result=full" >> ./aria2.conf
    echo "#dscp=" >> ./aria2.conf
    echo "enable-color=true" >> ./aria2.conf
    echo "enable-mmap=true" >> ./aria2.conf
    echo "event-poll=epoll" >> ./aria2.conf
    echo "file-allocation=falloc" >> ./aria2.conf
    echo "force-save=true" >> ./aria2.conf
    echo "force-sequential=false" >> ./aria2.conf
    echo "#gid=" >> ./aria2.conf
    echo "hash-check-only=false" >> ./aria2.conf
    echo "human-readable=true" >> ./aria2.conf
    echo "#interface=" >> ./aria2.conf
    echo "keep-unfinished-download-result=true" >> ./aria2.conf
    echo "log-level=error" >> ./aria2.conf
    echo "max-download-limit=0" >> ./aria2.conf
    echo "max-download-result=64" >> ./aria2.conf
    echo "max-mmap-limit=9223372036854775807" >> ./aria2.conf
    echo "max-overall-download-limit=0" >> ./aria2.conf
    echo "max-resume-failure-tries=5" >> ./aria2.conf
    echo "min-tls-version=TLSv1.2" >> ./aria2.conf
    echo "#multiple-interface=" >> ./aria2.conf
    echo "no-conf=false" >> ./aria2.conf
    echo "no-file-allocation-limit=64M" >> ./aria2.conf
    echo "#on-bt-download-complete=" >> ./aria2.conf
    echo "#on-download-complete=" >> ./aria2.conf
    echo "#on-download-error=" >> ./aria2.conf
    echo "#on-download-pause=" >> ./aria2.conf
    echo "#on-download-start=" >> ./aria2.conf
    echo "#on-download-stop=" >> ./aria2.conf
    echo "optimize-concurrent-downloads=true" >> ./aria2.conf
    echo "parameterized-uri=true" >> ./aria2.conf
    echo "piece-length=64M" >> ./aria2.conf
    echo "quiet=true" >> ./aria2.conf
    echo "realtime-chunk-checksum=true" >> ./aria2.conf
    echo "remove-control-file=true" >> ./aria2.conf
    echo "rlimit-nofile=65536" >> ./aria2.conf
    echo "save-not-found=true" >> ./aria2.conf
    echo "save-session-interval=5" >> ./aria2.conf
    echo "save-session=/etc/aria2/aria2.session" >> ./aria2.conf
    echo "show-console-readout=true" >> ./aria2.conf
    echo "socket-recv-buffer-size=0" >> ./aria2.conf
    echo "stderr=false" >> ./aria2.conf
    echo "#stop-with-process=" >> ./aria2.conf
    echo "stop=0" >> ./aria2.conf
    echo "summary-interval=5" >> ./aria2.conf
    echo "truncate-console-readout=true" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# Basic Options
function Basic_Options() {
    echo "## Basic Options" >> ./aria2.conf
    echo "check-integrity=true" >> ./aria2.conf
    echo "continue=true" >> ./aria2.conf
    echo "dir=/mnt/md0/Downloads" >> ./aria2.conf
    echo "input-file=/etc/aria2/aria2.session" >> ./aria2.conf
    echo "log=/etc/aria2/aria2.log" >> ./aria2.conf
    echo "max-concurrent-downloads=10" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# BitTorrent / Metalink Options
function BitTorrent_Metalink_Options() {
    echo "## BitTorrent / Metalink Options" >> ./aria2.conf
    echo "#select-file=" >> ./aria2.conf
    echo "show-files=false" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# HTTP / FTP / SFTP Options
function HTTP_FTP_SFTP_Options() {
    echo "## HTTP / FTP / SFTP Options" >> ./aria2.conf
    echo "#all-proxy-passwd=" >> ./aria2.conf
    echo "#all-proxy-user=" >> ./aria2.conf
    echo "#all-proxy=" >> ./aria2.conf
    echo "#checksum=" >> ./aria2.conf
    echo "connect-timeout=5" >> ./aria2.conf
    echo "dry-run=false" >> ./aria2.conf
    echo "lowest-speed-limit=0" >> ./aria2.conf
    echo "max-connection-per-server=16" >> ./aria2.conf
    echo "max-file-not-found=5" >> ./aria2.conf
    echo "max-tries=5" >> ./aria2.conf
    echo "min-split-size=64M" >> ./aria2.conf
    echo "netrc-path=/etc/aria2/aria2.netrc" >> ./aria2.conf
    echo "no-netrc=false" >> ./aria2.conf
    echo "#no-proxy=" >> ./aria2.conf
    echo "#out=" >> ./aria2.conf
    echo "proxy-method=get" >> ./aria2.conf
    echo "remote-time=true" >> ./aria2.conf
    echo "retry-wait=5" >> ./aria2.conf
    echo "reuse-uri=true" >> ./aria2.conf
    echo "server-stat-if=/etc/aria2/aria2.stat" >> ./aria2.conf
    echo "server-stat-of=/etc/aria2/aria2.stat" >> ./aria2.conf
    echo "server-stat-timeout=3600" >> ./aria2.conf
    echo "split=16" >> ./aria2.conf
    echo "stream-piece-selector=random" >> ./aria2.conf
    echo "timeout=5" >> ./aria2.conf
    echo "uri-selector=adaptive" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# BitTorrent Specific Options
function BitTorrent_Specific_Options() {
    echo "## BitTorrent Specific Options" >> ./aria2.conf
    echo "bt-detach-seed-only=true" >> ./aria2.conf
    echo "bt-enable-hook-after-hash-check=true" >> ./aria2.conf
    echo "bt-enable-lpd=true" >> ./aria2.conf
    echo "bt-exclude-tracker=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/trackerslist_exclude_aria2.txt")" >> ./aria2.conf
    echo "#bt-external-ip=" >> ./aria2.conf
    echo "bt-force-encryption=true" >> ./aria2.conf
    echo "bt-hash-check-seed=true" >> ./aria2.conf
    echo "bt-load-saved-metadata=true" >> ./aria2.conf
    echo "#bt-lpd-interface=" >> ./aria2.conf
    echo "bt-max-open-files=65536" >> ./aria2.conf
    echo "bt-max-peers=0" >> ./aria2.conf
    echo "bt-metadata-only=false" >> ./aria2.conf
    echo "bt-min-crypto-level=arc4" >> ./aria2.conf
    echo "#bt-prioritize-piece=" >> ./aria2.conf
    echo "bt-remove-unselected-file=true" >> ./aria2.conf
    echo "bt-request-peer-speed-limit=4M" >> ./aria2.conf
    echo "bt-require-crypto=true" >> ./aria2.conf
    echo "bt-save-metadata=true" >> ./aria2.conf
    echo "bt-seed-unverified=false" >> ./aria2.conf
    echo "bt-stop-timeout=0" >> ./aria2.conf
    echo "bt-tracker-connect-timeout=5" >> ./aria2.conf
    echo "bt-tracker-interval=0" >> ./aria2.conf
    echo "bt-tracker-timeout=5" >> ./aria2.conf
    echo "bt-tracker=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/master/trackerslist_tracker_aria2.txt")" >> ./aria2.conf
    echo "dht-entry-point6=dht.transmissionbt.com:6881" >> ./aria2.conf
    echo "dht-entry-point=dht.transmissionbt.com:6881" >> ./aria2.conf
    echo "dht-file-path6=/etc/aria2/aria2.dht6" >> ./aria2.conf
    echo "dht-file-path=/etc/aria2/aria2.dht" >> ./aria2.conf
    echo "#dht-listen-addr6=" >> ./aria2.conf
    echo "dht-listen-port=6881" >> ./aria2.conf
    echo "dht-message-timeout=5" >> ./aria2.conf
    echo "enable-dht6=true" >> ./aria2.conf
    echo "enable-dht=true" >> ./aria2.conf
    echo "enable-peer-exchange=true" >> ./aria2.conf
    echo "follow-torrent=true" >> ./aria2.conf
    echo "#index-out=" >> ./aria2.conf
    echo "listen-port=51413" >> ./aria2.conf
    echo "max-overall-upload-limit=0" >> ./aria2.conf
    echo "max-upload-limit=0" >> ./aria2.conf
    echo "peer-agent=Transmission/$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{ print $2 }' | sed "s/\ //g;s/\"//g;s/\,//g")" >> ./aria2.conf
    echo "peer-id-prefix=-TR$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{ print $2 }' | sed "s/\ //g;s/\"//g;s/\,//g;s/\.//g")0-" >> ./aria2.conf
    echo "seed-ratio=1.0" >> ./aria2.conf
    echo "seed-time=60" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# FTP / SFTP Specific Options
function FTP_SFTP_Specific_Options() {
    echo "## FTP / SFTP Specific Options" >> ./aria2.conf
    echo "ftp-passwd=TRANSMISSIONUSER@" >> ./aria2.conf
    echo "ftp-pasv=true" >> ./aria2.conf
    echo "#ftp-proxy-passwd=" >> ./aria2.conf
    echo "#ftp-proxy-user=" >> ./aria2.conf
    echo "#ftp-proxy=" >> ./aria2.conf
    echo "ftp-reuse-connection=true" >> ./aria2.conf
    echo "ftp-type=binary" >> ./aria2.conf
    echo "ftp-user=anonymous" >> ./aria2.conf
    echo "#ssh-host-key-md=" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# HTTP Specific Options
function HTTP_Specific_Options() {
    echo "## HTTP Specific Options" >> ./aria2.conf
    echo "#ca-certificate=" >> ./aria2.conf
    echo "#certificate=" >> ./aria2.conf
    echo "check-certificate=true" >> ./aria2.conf
    echo "enable-http-keep-alive=true" >> ./aria2.conf
    echo "enable-http-pipelining=true" >> ./aria2.conf
    echo "#header=" >> ./aria2.conf
    echo "http-accept-gzip=true" >> ./aria2.conf
    echo "http-auth-challenge=true" >> ./aria2.conf
    echo "http-no-cache=false" >> ./aria2.conf
    echo "#http-passwd=" >> ./aria2.conf
    echo "#http-proxy-passwd=" >> ./aria2.conf
    echo "#http-proxy-user=" >> ./aria2.conf
    echo "#http-proxy=" >> ./aria2.conf
    echo "#http-user=" >> ./aria2.conf
    echo "#https-proxy-passwd=" >> ./aria2.conf
    echo "#https-proxy-user=" >> ./aria2.conf
    echo "#https-proxy=" >> ./aria2.conf
    echo "load-cookies=/etc/aria2/aria2.cookies" >> ./aria2.conf
    echo "#private-key=" >> ./aria2.conf
    echo "#referer=" >> ./aria2.conf
    echo "save-cookies=/etc/aria2/aria2.cookies" >> ./aria2.conf
    echo "use-head=true" >> ./aria2.conf
    echo "user-agent=Transmission/$(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/releases/latest" | grep "tag_name" | head -n 1 | awk -F ":" '{ print $2 }' | sed "s/\ //g;s/\"//g;s/\,//g")" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# Metalink Specific Options
function Metalink_Specific_Options() {
    echo "## Metalink Specific Options" >> ./aria2.conf
    echo "follow-metalink=mem" >> ./aria2.conf
    echo "#metalink-base-uri=" >> ./aria2.conf
    echo "metalink-enable-unique-protocol=false" >> ./aria2.conf
    echo "#metalink-file=" >> ./aria2.conf
    echo "#metalink-language=" >> ./aria2.conf
    echo "#metalink-location=" >> ./aria2.conf
    echo "#metalink-os=" >> ./aria2.conf
    echo "metalink-preferred-protocol=https" >> ./aria2.conf
    echo "#metalink-version=" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# RPC Options
function RPC_Options() {
    echo "## RPC Options" >> ./aria2.conf
    echo "enable-rpc=true" >> ./aria2.conf
    echo "pause-metadata=false" >> ./aria2.conf
    echo "pause=false" >> ./aria2.conf
    echo "rpc-allow-origin-all=true" >> ./aria2.conf
    echo "#rpc-certificate=" >> ./aria2.conf
    echo "rpc-listen-all=true" >> ./aria2.conf
    echo "rpc-listen-port=6800" >> ./aria2.conf
    echo "rpc-max-request-size=64M" >> ./aria2.conf
    echo "#rpc-private-key=" >> ./aria2.conf
    echo "rpc-save-upload-metadata=true" >> ./aria2.conf
    echo "#rpc-secret=" >> ./aria2.conf
    echo "rpc-secure=false" >> ./aria2.conf
    echo "" >> ./aria2.conf
}
# Generate Footer
function GenerateFooter() {
    echo "# /etc/aria2/aria2.conf End" >> ./aria2.conf
    exit 0
}

## Process
# Call GenerateHeader
GenerateHeader
# Call Advanced_Options
Advanced_Options
# Call Basic_Options
Basic_Options
# Call BitTorrent_Metalink_Options
BitTorrent_Metalink_Options
# Call HTTP_FTP_SFTP_Options
HTTP_FTP_SFTP_Options
# Call BitTorrent_Specific_Options
BitTorrent_Specific_Options
# Call FTP_SFTP_Specific_Options
FTP_SFTP_Specific_Options
# Call HTTP_Specific_Options
HTTP_Specific_Options
# Call Metalink_Specific_Options
Metalink_Specific_Options
# Call RPC_Options
RPC_Options
# Call GenerateFooter
GenerateFooter
