#!/bin/bash

# Current Version: 1.0.6

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && bash ./aria2.conf/aria2.sh -c https://alidns.com -e 86400 -m a2 -s true -u true

## Parameter
while getopts c:e:m:s:u: GetParameter; do
    case ${GetParameter} in
        c) CHECKALIVE="${OPTARG}";;
        e) EXPIRATION="${OPTARG}";;
        m) MASQUERADE="${OPTARG}";;
        s) SYNCREMOTE="${OPTARG}";;
        u) SELFUPDATE="${OPTARG}";;
    esac
done

## Function
# Check Configuration Validity
function CheckConfigurationValidity() {
    if [ "${CHECKALIVE}" == "" ]; then
        echo "An error occurred during processing. Missing (CHECKALIVE) value, please check it and try again."
        exit 1
    elif [ "$(echo ${CHECKALIVE} | grep -E '^(ftp|https|http|sftp)://(([a-z]{1})|([a-z]{1}[a-z]{1})|([a-z]{1}[0-9]{1})|([0-9]{1}[a-z]{1})|([a-z0-9][-\.a-z0-9]{1,61}[a-z0-9]))\.([a-z]{2,13}|[a-z0-9-]{2,30}\.[a-z]{2,3})$')" == "" ]; then
        echo "An error occurred during processing. Invalid (CHECKALIVE) value, please check it and try again."
        exit 1
    fi
    if [ "${EXPIRATION}" == "" ]; then
        echo "An error occurred during processing. Missing (EXPIRATION) value, please check it and try again."
        exit 1
    elif [ "$(echo ${EXPIRATION} | grep -E '^[0-9]*$')" == "" ]; then
        echo "An error occurred during processing. Invalid (EXPIRATION) value, please check it and try again."
        exit 1
    fi
    if [ "${MASQUERADE}" == "" ]; then
        echo "An error occurred during processing. Missing (MASQUERADE) value, please check it and try again."
        exit 1
    elif [ "${MASQUERADE}" != "a2" ] && [ "${MASQUERADE}" != "tr" ] && [ "${MASQUERADE}" != "qb" ]; then
        echo "An error occurred during processing. Invalid (MASQUERADE) value, please check it and try again."
        exit 1
    fi
    if [ "${SYNCREMOTE}" == "" ]; then
        echo "An error occurred during processing. Missing (SYNCREMOTE) value, please check it and try again."
        exit 1
    elif [ "${SYNCREMOTE}" != "false" ] && [ "${SYNCREMOTE}" != "true" ]; then
        echo "An error occurred during processing. Invalid (SYNCREMOTE) value, please check it and try again."
        exit 1
    fi
    if [ "${SELFUPDATE}" == "" ]; then
        echo "An error occurred during processing. Missing (SELFUPDATE) value, please check it and try again."
        exit 1
    elif [ "${SELFUPDATE}" != "false" ] && [ "${SELFUPDATE}" != "true" ]; then
        echo "An error occurred during processing. Invalid (SELFUPDATE) value, please check it and try again."
        exit 1
    fi
}
# Check Environment
function CheckEnvironment() {
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
    if [ ! -f "/etc/aria2/work/aria2.cookie" ]; then
        touch "/etc/aria2/work/aria2.cookie"
    fi
    if [ ! -f "/etc/aria2/work/aria2.dht" ]; then
        touch "/etc/aria2/work/aria2.dht"
    fi
    if [ ! -f "/etc/aria2/work/aria2.dht6" ]; then
        touch "/etc/aria2/work/aria2.dht6"
    fi
    if [ ! -f "/etc/aria2/work/aria2.exp" ]; then
        echo "$(date '+%s')" > "/etc/aria2/work/aria2.exp"
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
}
# Check Requirement
function CheckRequirement() {
    which "aria2c" > "/dev/null" 2>&1
    if [ "$?" -eq "1" ]; then
        echo "aria2c is not existed."
        exit 1
    fi
    which "ifconfig" > "/dev/null" 2>&1
    if [ "$?" -eq "1" ]; then
        echo "ifconfig is not existed."
        exit 1
    fi
}
# Get aria2c Function
function Getaria2cFunction() {
    function Getaria2cMemory() {
        if [ -f "/proc/meminfo" ]; then
            aria2c_max_memory=$(( $(cat "/proc/meminfo" | tr "A-Z" "a-z" | grep "memtotal" | tr -d " :a-z") * 1024 / 8 ))
        else
            aria2c_max_memory="0"
        fi
        if [ "${aria2c_max_memory}" != "0" ]; then
            aria2c_disk_cache_option="s/disk\-cache\=0/disk\-cache\=${aria2c_max_memory}/g;"
        fi
    }
    function Getaria2cNetwork() {
        current_ip=$(wget -qO- "https://ifconfig.zhijie.online/ip" | grep '"ip"' | sed "s/\ \ \"ip\"\:\ \"//g;s/\"\,//g")
        current_interface=$(ifconfig -a | grep "inet")
        ipv4_address=$(echo "${current_ip}" | grep -E "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}$")
        ipv4_interface=$(echo "${current_interface}" | grep -v "inet6")
        ipv6_address=$(echo "${current_ip}" | grep -E "^(([0-9a-f]{1,4}:){7,7}[0-9a-f]{1,4}|([0-9a-f]{1,4}:){1,7}:|([0-9a-f]{1,4}:){1,6}:[0-9a-f]{1,4}|([0-9a-f]{1,4}:){1,5}(:[0-9a-f]{1,4}){1,2}|([0-9a-f]{1,4}:){1,4}(:[0-9a-f]{1,4}){1,3}|([0-9a-f]{1,4}:){1,3}(:[0-9a-f]{1,4}){1,4}|([0-9a-f]{1,4}:){1,2}(:[0-9a-f]{1,4}){1,5}|[0-9a-f]{1,4}:((:[0-9a-f]{1,4}){1,6})|:((:[0-9a-f]{1,4}){1,7}|:)|fe80:(:[0-9a-f]{0,4}){0,4}%[0-9a-z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-f]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$")
        ipv6_interface=$(echo "${current_interface}" | grep "inet6")
        if [ "${ipv6_address}" == "" ] && [ "${ipv6_interface}" == "" ]; then
            aria2c_ipv6_option="s/dht\-entry\-point6\=/\#dht\-entry\-point6\=/g;s/dht\-file\-path6\=/\#dht\-file\-path6\=/g;s/disable\-ipv6\=false/disable\-ipv6\=true/g;s/enable\-dht6\=true/enable\-dht6\=false/g;"
        fi
    }
    function Getaria2cThread() {
        if [ -f "/proc/cpuinfo" ]; then
            for aria2c_max_thread in $(( $(cat "/proc/cpuinfo" | grep "processor" | wc -l) * 64 )) 16; do
                aria2c -x "${aria2c_max_thread}" --dry-run "${CHECKALIVE}" > "/dev/null" 2>&1
                if [ "$?" -eq "0" ]; then
                    break
                fi
            done
        else
            aria2c_max_thread="16"
        fi
        if [ "${aria2c_max_thread}" != "16" ]; then
            aria2c_thread_option="s/max\-connection\-per\-server\=16/max\-connection\-per\-server\=${aria2c_max_thread}/g;s/split\=16/split\=${aria2c_max_thread}/g;"
        fi
    }
    aria2c_function=$(aria2c --help="#all")
    aria2c_http_want_digest=$(echo "${aria2c_function}" | grep "\-\-http\-want\-digest")
    aria2c_retry_on_400=$(echo "${aria2c_function}" | grep "\-\-retry\-on\-400")
    aria2c_retry_on_403=$(echo "${aria2c_function}" | grep "\-\-retry\-on\-403")
    aria2c_retry_on_406=$(echo "${aria2c_function}" | grep "\-\-retry\-on\-406")
    aria2c_retry_on_unknown=$(echo "${aria2c_function}" | grep "\-\-retry\-on\-unknown")
    Getaria2cMemory && Getaria2cNetwork && Getaria2cThread && aria2c_extra_option="${aria2c_disk_cache_option}${aria2c_ipv6_option}${aria2c_thread_option}"
    if [ "${aria2c_http_want_digest}" != "" ]; then
        aria2c_extra_option="${aria2c_extra_option}s/\#http\-want\-digest\=/http\-want\-digest\=false/g;"
    fi
    if [ "${aria2c_retry_on_400}" != "" ]; then
        aria2c_extra_option="${aria2c_extra_option}s/\#retry\-on\-400\=/retry\-on\-400\=true/g;"
    fi
    if [ "${aria2c_retry_on_403}" != "" ]; then
        aria2c_extra_option="${aria2c_extra_option}s/\#retry\-on\-403\=/retry\-on\-403\=true/g;"
    fi
    if [ "${aria2c_retry_on_406}" != "" ]; then
        aria2c_extra_option="${aria2c_extra_option}s/\#retry\-on\-406\=/retry\-on\-406\=true/g;"
    fi
    if [ "${aria2c_retry_on_unknown}" != "" ]; then
        aria2c_extra_option="${aria2c_extra_option}s/\#retry\-on\-unknown\=/retry\-on\-unknown\=true/g;"
    fi
}
# Get aria2c PID
function Getaria2cPID() {
    aria2c_pid=$(ps -ef | grep "aria2c" | grep -v "grep" | awk '{ print $2 }')
}
# Get Current Expired Date
function GetCurrentExpiredDate() {
    current_date=$(date "+%s")
    expired_date=$(cat "/etc/aria2/work/aria2.exp")
}
# Get Remote Configuration File
function GetRemoteConfigurationFile() {
    if [ "${ipv4_address}" != "" ] || [ "${ipv6_address}" != "" ]; then
        if [ ! -f "/etc/aria2/conf/aria2.conf" ] || [ ! -s "/etc/aria2/conf/aria2.conf" ]; then
            ARIA2_CONF=$(wget -qO- "https://source.zhijie.online/aria2.conf/main/aria2_${MASQUERADE}_linux.conf")
            echo "${ARIA2_CONF}" | sed "${aria2c_extra_option}" > "/etc/aria2/conf/aria2.conf"
        elif [ "${SYNCREMOTE}" == "true" ] && [ "${expired_date}" -le "${current_date}" ]; then
            ARIA2_CONF=$(wget -qO- "https://source.zhijie.online/aria2.conf/main/aria2_${MASQUERADE}_linux.conf")
            echo "${ARIA2_CONF}" | sed "${aria2c_extra_option}" | sed "s/\#rpc\-certificate\=\/etc\/aria2\/cert\/fullchain\.pem/$(cat '/etc/aria2/conf/aria2.conf' | grep 'rpc\-certificate' | sed 's/\//\\\//g')/g;s/\#rpc\-private\-key\=\/etc\/aria2\/cert\/privkey\.pem/$(cat '/etc/aria2/conf/aria2.conf' | grep 'rpc\-private\-key' | sed 's/\//\\\//g')/g;s/\#rpc\-secret\=/$(cat '/etc/aria2/conf/aria2.conf' | grep 'rpc\-secret')/g;s/rpc\-secure\=false/$(cat '/etc/aria2/conf/aria2.conf' | grep 'rpc\-secure')/g" > "/etc/aria2/conf/aria2.conf"
        fi && echo "$(( $(date '+%s') + ${EXPIRATION} ))" > "/etc/aria2/work/aria2.exp"
    fi
}
# Self Update
function SelfUpdate() {
    if [ "${ipv4_address}" != "" ] || [ "${ipv6_address}" != "" ]; then
        if [ "${SELFUPDATE}" == "true" ] && [ "${expired_date}" -le "${current_date}" ]; then
            ARIA2_SH=$(wget -qO- "https://source.zhijie.online/aria2.conf/source/aria2.sh")
            if [ "$(cat '/etc/aria2/aria2.sh' | grep 'Current\ Version' | sed 's/\#\ Current\ Version\:\ //g')" != "$(echo ${ARIA2_SH} | grep 'Current\ Version' | sed 's/\#\ Current\ Version\:\ //g')" ]; then
                echo "${ARIA2_SH}" > "/etc/aria2/aria2.sh"
            fi && echo "$(( $(date '+%s') + ${EXPIRATION} ))" > "/etc/aria2/work/aria2.exp"
        fi
    fi
}
# Run or Kill aria2c
function RunorKillaria2c() {
    if [ "${aria2c_pid}" == "" ]; then
        aria2c --conf-path="/etc/aria2/conf/aria2.conf"
        exit 0
    else
        kill "${aria2c_pid}"
        exit 0
    fi
}

## Process
# Call CheckConfigurationValidity
CheckConfigurationValidity
# Call CheckEnvironment
CheckEnvironment
# Call CheckRequirement
CheckRequirement
# Call Getaria2cFunction
Getaria2cFunction
# Call Getaria2cPID
Getaria2cPID
# Call GetCurrentExpiredDate
GetCurrentExpiredDate
# Call GetRemoteConfigurationFile
GetRemoteConfigurationFile
# Call SelfUpdate
SelfUpdate
# Call RunorKillaria2c
RunorKillaria2c
