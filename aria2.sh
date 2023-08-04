#!/bin/bash

# Parameter
OWNER="hezhijie0327"
REPO="aria2"
TAG="latest"
DOCKER_PATH="/docker/aria2"

CURL_OPTION=""
DOWNLOAD_CONFIG="" # false, a2, tr, qb
USE_CDN="true"

ARIA2_DHT_LISTEN_PORT="" # 6881-6999
ARIA2_LISTEN_PORT="" # 6881-6999

ARIA2_BT_PIECE_SELECTOR="" # inorder, random

ARIA2_DISABLE_IPV6="" # false, true

ARIA2_DISK_CACHE="" # 0, 16M

ARIA2_MAX_CONNECTION_PER_SERVER="" # 16
ARIA2_SPLIT="" # 16

ARIA2_RETRY_ON_400="" # false, true
ARIA2_RETRY_ON_403="" # false, true
ARIA2_RETRY_ON_406="" # false, true
ARIA2_RETRY_ON_UNKNOWN="" # false, true

ARIA2_RPC_PORT="" # 6800
ARIA2_RPC_SECRET=""
ARIA2_RPC_SECURE="" # false, true

SSL_CERT="fullchain.cer"
SSL_KEY="zhijie.online.key"

## Function
# Get Latest Image
function GetLatestImage() {
    docker pull ${OWNER}/${REPO}:${TAG} && IMAGES=$(docker images -f "dangling=true" -q)
}
# Cleanup Current Container
function CleanupCurrentContainer() {
    if [ $(docker ps -a --format "table {{.Names}}" | grep -E "^${REPO}$") ]; then
        docker stop ${REPO} && docker rm ${REPO}
    fi
}
# Download Configuration
function DownloadConfiguration() {
    if [ "${USE_CDN}" == "true" ]; then
        CDN_PATH="source.zhijie.online"
    else
        CDN_PATH="raw.githubusercontent.com/hezhijie0327"
    fi

    if [ ! -d "${DOCKER_PATH}/conf" ]; then
        mkdir -p "${DOCKER_PATH}/conf"
    fi

    if [ "${DOWNLOAD_CONFIG:-a2}" != "false" ]; then
        curl ${CURL_OPTION:--4 -s --connect-timeout 15} "https://${CDN_PATH}/aria2.conf/main/aria2_${DOWNLOAD_CONFIG:-a2}_linux.conf" | sed "s/fullchain\.cer/${SSL_CERT/./\\.}/g;s/zhijie\.online\.key/${SSL_KEY/./\\.}/g" > "${DOCKER_PATH}/conf/aria2.conf"

        if [ "${ARIA2_DHT_LISTEN_PORT}" != "" ]; then
            sed -i "s/dht\-listen\-port\=6881\-6999/dht\-listen\-port\=${ARIA2_DHT_LISTEN_PORT}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_LISTEN_PORT}" != "" ]; then
            sed -i "s/listen\-port\=6881\-6999/listen\-port\=${ARIA2_LISTEN_PORT}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_BT_PIECE_SELECTOR}" != "" ]; then
            sed -i "s/\#bt\-piece\-selector\=/bt\-piece\-selector\=${ARIA2_BT_PIECE_SELECTOR}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_DISABLE_IPV6}" != "false" ]; then
            sed -i "s/dht\-entry\-point6\=/\#dht\-entry\-point6\=/g;s/dht\-file\-path6\=/\#dht\-file\-path6\=/g;s/disable\-ipv6\=false/disable\-ipv6\=true/g;s/enable\-async\-dns6\=true/enable\-async\-dns6\=false/g;s/enable\-dht6\=true/enable\-dht6\=false/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_DISK_CACHE}" != "" ]; then
            sed -i "s/disk\-cache\=0/disk\-cache\=${ARIA2_DISK_CACHE}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_MAX_CONNECTION_PER_SERVER}" != "" ]; then
            sed -i "s/max\-connection\-per\-server\=16/max\-connection\-per\-server\=${ARIA2_MAX_CONNECTION_PER_SERVER}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_SPLIT}" != "" ]; then
            sed -i "s/split\=16/split\=${ARIA2_SPLIT}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_RETRY_ON_400}" != "false" ]; then
            sed -i "s/\#retry\-on\-400\=/retry\-on\-400\=true/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_RETRY_ON_403}" != "false" ]; then
            sed -i "s/\#retry\-on\-403\=/retry\-on\-403\=true/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_RETRY_ON_406}" != "false" ]; then
            sed -i "s/\#retry\-on\-406\=/retry\-on\-406\=true/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_RETRY_ON_UNKNOWN}" != "false" ]; then
            sed -i "s/\#retry\-on\-unknown\=/retry\-on\-unknown\=true/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi

        if [ "${ARIA2_RPC_PORT}" != "" ]; then
            sed -i "s/rpc\-listen\-port\=6800/rpc\-listen\-port\=${ARIA2_RPC_PORT}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_RPC_SECRET}" != "" ]; then
            sed -i "s/#rpc\-secret\=/rpc\-secret\=${ARIA2_RPC_SECRET}/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
        if [ "${ARIA2_RPC_SECURE}" != "false" ]; then
            sed -i "s/#rpc-certificate/rpc-certificate/g;s/#rpc-private-key/rpc-private-key/g;s/rpc\-secure\=false/rpc\-secure\=true/g" "${DOCKER_PATH}/conf/aria2.conf"
        fi
    fi

    if [ ! -d "${DOCKER_PATH}/work" ]; then
        mkdir "${DOCKER_PATH}/work"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.cookie" ]; then
        touch "${DOCKER_PATH}/work/aria2.cookie"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.dht" ]; then
        touch "${DOCKER_PATH}/work/aria2.dht"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.dht6" ]; then
        touch "${DOCKER_PATH}/work/aria2.dht6"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.log" ]; then
        touch "${DOCKER_PATH}/work/aria2.log"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.netrc" ]; then
        touch "${DOCKER_PATH}/work/aria2.netrc"
    fi && chmod 600 "${DOCKER_PATH}/work/aria2.netrc"
    if [ ! -f "${DOCKER_PATH}/work/aria2.session" ]; then
        touch "${DOCKER_PATH}/work/aria2.session"
    fi
    if [ ! -f "${DOCKER_PATH}/work/aria2.stat" ]; then
        touch "${DOCKER_PATH}/work/aria2.stat"
    fi
}
# Create New Container
function CreateNewContainer() {
    docker run --name ${REPO} --net host --restart=always \
        -v /docker/ssl:/etc/aria2/cert:ro \
        -v ${DOCKER_PATH}/conf:/etc/aria2/conf \
        -v ${DOCKER_PATH}/data:/etc/aria2/data \
        -v ${DOCKER_PATH}/work:/etc/aria2/work \
        -d ${OWNER}/${REPO}:${TAG} \
        --conf-path="/etc/aria2/conf/aria2.conf"
}
# Cleanup Expired Image
function CleanupExpiredImage() {
    if [ "${IMAGES}" != "" ]; then
        docker rmi ${IMAGES}
    fi
}

## Process
# Call GetLatestImage
GetLatestImage
# Call CleanupCurrentContainer
CleanupCurrentContainer
# Call DownloadConfiguration
DownloadConfiguration
# Call CreateNewContainer
CreateNewContainer
# Call CleanupExpiredImage
CleanupExpiredImage
