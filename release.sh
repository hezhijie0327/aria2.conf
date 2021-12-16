#!/bin/bash

# Current Version: 1.0.5

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && bash ./aria2.conf/release.sh

## Function
# Get Trackerslist Data
function GetTrackerslistData() {
    excludelist_data=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/main/trackerslist_exclude_aria2.txt")
    trackerlist_data=$(curl -s --connect-timeout 15 "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/main/trackerslist_tracker_aria2.txt")
}
# Get Masquerade Data
function GetMasqueradeData() {
    aria2_version=($(curl -s --connect-timeout 15 "https://api.github.com/repos/aria2/aria2/tags" | grep "\"name\"\:" | tr -cd "[:digit:].\n" | grep -E "^[0-9]{1}.[0-9]{2}.[0-9]{1}$" | sort -r | uniq | awk "{ print $2 }"))
    curl_version=($(curl -s --connect-timeout 15 "https://api.github.com/repos/curl/curl/tags" | grep "\"name\"\:" | tr -cd "[:digit:]_\n" | grep -E "^[0-9]{1}_[0-9]{2}_[0-9]{1}$" | sort -r | uniq | awk "{ print $2 }"))
    qBittorrent_version=($(curl -s --connect-timeout 15 "https://api.github.com/repos/qbittorrent/qBittorrent/tags" | grep "\"name\"\:" | tr -cd "[:digit:].\n" | grep -E "^[0-9]{1}.[0-9]{1}.[0-9]{1}$" | sort -r | uniq | awk "{ print $2 }"))
    Transmission_version=($(curl -s --connect-timeout 15 "https://api.github.com/repos/transmission/transmission/tags" | grep "\"name\"\:" | tr -cd "[:digit:].\n" | grep -E "^[0-9]{1}.[0-9]{2}$" | sort -r | uniq | awk "{ print $2 }"))
}
# Generate aria2c Options
function Generatearia2cOptions() {
    aria2c_options=(
        "all-proxy-passwd="
        "all-proxy-user="
        "all-proxy="
        "allow-overwrite=false"
        "allow-piece-length-change=true"
        "always-resume=true"
        "async-dns-server="
        "async-dns=true"
        "auto-file-renaming=true"
        "auto-save-interval=1"
        "bt-detach-seed-only=true"
        "bt-enable-hook-after-hash-check=true"
        "bt-enable-lpd=true"
        "bt-exclude-tracker=${excludelist_data}"
        "bt-external-ip="
        "bt-force-encryption=true"
        "bt-hash-check-seed=true"
        "bt-load-saved-metadata=true"
        "bt-lpd-interface="
        "bt-max-open-files=4096"
        "bt-max-peers=0"
        "bt-metadata-only=false"
        "bt-min-crypto-level=arc4"
        "bt-piece-selector="
        "bt-prioritize-piece=head,tail"
        "bt-remove-unselected-file=true"
        "bt-request-peer-speed-limit=125M"
        "bt-require-crypto=true"
        "bt-save-metadata=true"
        "bt-seed-unverified=false"
        "bt-stop-timeout=0"
        "bt-tracker-connect-timeout=5"
        "bt-tracker-interval=1"
        "bt-tracker-timeout=5"
        "bt-tracker=${trackerlist_data}"
        "bt-udp-socks-proxy-passwd="
        "bt-udp-socks-proxy-user="
        "bt-udp-socks-proxy="
        "ca-certificate="
        "certificate="
        "check-certificate=true"
        "check-integrity=true"
        "checksum="
        "conditional-get=false"
        "conf-path=${aria2c_dir}${aria2c_conf_dir}aria2.conf"
        "connect-timeout=5"
        "console-log-level=error"
        "content-disposition-default-utf8=true"
        "continue=true"
        "daemon=false"
        "deferred-input=false"
        "dht-entry-point6=dht.transmissionbt.com:6881"
        "dht-entry-point=dht.transmissionbt.com:6881"
        "dht-file-path6=${aria2c_dir}${aria2c_work_dir}aria2.dht6"
        "dht-file-path=${aria2c_dir}${aria2c_work_dir}aria2.dht"
        "dht-listen-addr6="
        "dht-listen-port=6881-6889,51413"
        "dht-message-timeout=5"
        "dir=${aria2c_dir}${aria2c_data_dir}"
        "disable-ipv6=false"
        "disk-cache=0"
        "download-result=full"
        "dry-run=false"
        "dscp=32"
        "enable-async-dns6=true"
        "enable-color=true"
        "enable-dht6=true"
        "enable-dht=true"
        "enable-http-keep-alive=true"
        "enable-http-pipelining=true"
        "enable-mmap=true"
        "enable-peer-exchange=true"
        "enable-rpc=true"
        "event-poll=${event_poll}"
        "file-allocation=falloc"
        "follow-metalink=mem"
        "follow-torrent=mem"
        "force-save=true"
        "force-sequential=true"
        "ftp-passwd=${ftp_passwd}"
        "ftp-pasv=true"
        "ftp-proxy-passwd="
        "ftp-proxy-user="
        "ftp-proxy="
        "ftp-reuse-connection=true"
        "ftp-type=binary"
        "ftp-user=anonymous"
        "gid="
        "hash-check-only=false"
        "header="
        "help"
        "http-accept-gzip=true"
        "http-auth-challenge=true"
        "http-no-cache=true"
        "http-passwd="
        "http-proxy-passwd="
        "http-proxy-user="
        "http-proxy="
        "http-user="
        "http-want-digest="
        "https-proxy-passwd="
        "https-proxy-user="
        "https-proxy="
        "human-readable=true"
        "index-out="
        "input-file=${aria2c_dir}${aria2c_work_dir}aria2.session"
        "interface="
        "keep-unfinished-download-result=true"
        "listen-port=6881-6889,51413"
        "load-cookies=${aria2c_dir}${aria2c_work_dir}aria2.cookie"
        "log-level=error"
        "log=${aria2c_dir}${aria2c_work_dir}aria2.log"
        "lowest-speed-limit=0"
        "max-concurrent-downloads=10"
        "max-connection-per-server=16"
        "max-download-limit=0"
        "max-download-result=10"
        "max-file-not-found=5"
        "max-mmap-limit=9223372036854775807"
        "max-overall-download-limit=0"
        "max-overall-upload-limit=0"
        "max-resume-failure-tries=0"
        "max-tries=0"
        "max-upload-limit=0"
        "metalink-base-uri="
        "metalink-enable-unique-protocol=true"
        "metalink-file="
        "metalink-language="
        "metalink-location="
        "metalink-os="
        "metalink-preferred-protocol=https"
        "metalink-version="
        "min-split-size=4K"
        "min-tls-version=TLSv1.2"
        "multiple-interface="
        "netrc-path=${aria2c_dir}${aria2c_work_dir}aria2.netrc"
        "no-conf=false"
        "no-file-allocation-limit=4K"
        "no-netrc=false"
        "no-proxy="
        "on-bt-download-complete="
        "on-download-complete="
        "on-download-error="
        "on-download-pause="
        "on-download-start="
        "on-download-stop="
        "optimize-concurrent-downloads=true"
        "out="
        "parameterized-uri=true"
        "pause-metadata=true"
        "pause=false"
        "peer-agent=${peer_agent}"
        "peer-id-prefix=${peer_id_prefx}"
        "piece-length=4K"
        "private-key="
        "proxy-method=tunnel"
        "quiet=false"
        "realtime-chunk-checksum=true"
        "referer=*"
        "remote-time=true"
        "remove-control-file=true"
        "retry-on-400="
        "retry-on-403="
        "retry-on-406="
        "retry-on-unknown="
        "retry-wait=5"
        "reuse-uri=true"
        "rlimit-nofile="
        "rpc-allow-origin-all=true"
        "rpc-certificate=${aria2c_dir}${aria2c_cert_dir}fullchain.pem"
        "rpc-listen-all=true"
        "rpc-listen-port=6800"
        "rpc-max-request-size=4M"
        "rpc-passwd="
        "rpc-private-key=${aria2c_dir}${aria2c_cert_dir}privkey.pem"
        "rpc-save-upload-metadata=true"
        "rpc-secret="
        "rpc-secure=false"
        "rpc-user="
        "save-cookies=${aria2c_dir}${aria2c_work_dir}aria2.cookie"
        "save-not-found=true"
        "save-session-interval=1"
        "save-session=${aria2c_dir}${aria2c_work_dir}aria2.session"
        "seed-ratio=1.0"
        "seed-time=60"
        "select-file="
        "server-stat-if=${aria2c_dir}${aria2c_work_dir}aria2.stat"
        "server-stat-of=${aria2c_dir}${aria2c_work_dir}aria2.stat"
        "server-stat-timeout=3600"
        "show-console-readout=true"
        "show-files=true"
        "socket-recv-buffer-size=4M"
        "split=16"
        "ssh-host-key-md="
        "stderr=true"
        "stop-with-process="
        "stop=0"
        "stream-piece-selector=inorder"
        "summary-interval=1"
        "timeout=5"
        "torrent-file="
        "truncate-console-readout=true"
        "uri-selector=adaptive"
        "use-head=true"
        "user-agent=${user_agent}"
        "version"
    )
}
# Generate Masquerade Info
function GenerateMasqueradeInfo() {
    if [ "${software_prefix}" == "qb" ]; then
        ftp_passwd="QBITTORRENTUSER@"
        peer_agent="qBittorrent/${qBittorrent_version[0]}"
        peer_id_prefx="-qB$(echo "${qBittorrent_version[0]}" | sed "s/\.//g")0-"
        user_agent="curl/$(echo "${curl_version[0]}" | sed "s/\_/\./g")"
    elif [ "${software_prefix}" == "tr" ]; then
        ftp_passwd="TRANSMISSIONUSER@"
        peer_agent="Transmission/${Transmission_version[0]}"
        peer_id_prefx="-TR$(echo "${Transmission_version[0]}" | sed "s/\.//g")0-"
        user_agent="curl/$(echo "${curl_version[0]}" | sed "s/\_/\./g")"
    else
        ftp_passwd="ARIA2USER@"
        peer_agent="aria2/${aria2_version[0]}"
        peer_id_prefx="A2-$(echo "${aria2_version[0]}" | sed "s/\./\-/g")-"
        user_agent="curl/$(echo "${curl_version[0]}" | sed "s/\_/\./g")"
    fi
}
# Output aria2c Options
function Outputaria2cOptions() {
    for aria2c_options_task in "${!aria2c_options[@]}"; do
        if [ "$(echo ${aria2c_options[$aria2c_options_task]} | grep 'rpc\-certificate\|rpc\-private\-key')" != "" ]; then
            echo "#${aria2c_options[$aria2c_options_task]}" >> ./aria2_${software_prefix}_${os_name}.conf
        elif [ "$(echo ${aria2c_options[$aria2c_options_task]} | grep '\=')" != "" ] && [ "$(echo ${aria2c_options[$aria2c_options_task]} | sed 's/^.*\=//g')" != "" ]; then
            echo "${aria2c_options[$aria2c_options_task]}" >> ./aria2_${software_prefix}_${os_name}.conf
        else
            echo "#${aria2c_options[$aria2c_options_task]}" >> ./aria2_${software_prefix}_${os_name}.conf
        fi
    done
}
# Output Data
function OutputData() {
    rm -rf ./aria2_*.conf
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="epoll" && os_name="linux" && software_prefix="a2" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="epoll" && os_name="linux" && software_prefix="qb" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="epoll" && os_name="linux" && software_prefix="tr" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="kqueue" && os_name="macos" && software_prefix="a2" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="kqueue" && os_name="macos" && software_prefix="qb" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="/etc/aria2/" && aria2c_cert_dir="cert/" && aria2c_conf_dir="conf/" && aria2c_data_dir="data" && aria2c_work_dir="work/" && event_poll="kqueue" && os_name="macos" && software_prefix="tr" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="C:\Program Files\\aria2\\" && aria2c_cert_dir="cert\\" && aria2c_conf_dir="conf\\" && aria2c_data_dir="data" && aria2c_work_dir="work\\" && event_poll="select" && os_name="windows" && software_prefix="a2" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="C:\Program Files\\aria2\\" && aria2c_cert_dir="cert\\" && aria2c_conf_dir="conf\\" && aria2c_data_dir="data" && aria2c_work_dir="work\\" && event_poll="select" && os_name="windows" && software_prefix="qb" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    aria2c_dir="C:\Program Files\\aria2\\" && aria2c_cert_dir="cert\\" && aria2c_conf_dir="conf\\" && aria2c_data_dir="data" && aria2c_work_dir="work\\" && event_poll="select" && os_name="windows" && software_prefix="tr" && GenerateMasqueradeInfo && Generatearia2cOptions && Outputaria2cOptions
    exit 0
}

## Process
# Call GetTrackerslistData
GetTrackerslistData
# Call GetMasqueradeData
GetMasqueradeData
# Call OutputData
OutputData
