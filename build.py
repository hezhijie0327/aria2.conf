#!/usr/bin/env python3

## How to get and use?
# git clone "https://github.com/hezhijie0327/aria2.conf.git" && python3 ./aria2.conf/build.py

# Current Version: 1.2.1

import json
import re
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parent

EXCLUDELIST_URL = "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/main/dist/exclude_aria2.txt"
TRACKERLIST_URL = "https://raw.githubusercontent.com/hezhijie0327/Trackerslist/main/dist/tracker_aria2.txt"

# GitHub tag endpoints used to masquerade as the latest client versions
MASQUERADE_REPOS = {
    "aria2": ("aria2/aria2", r"^refs/tags/release-", "refs/tags/release-"),
    "deluge": ("deluge-torrent/deluge", r"^refs/tags/deluge-", "refs/tags/deluge-"),
    "libtorrent": ("arvidn/libtorrent", r"^refs/tags/v", "refs/tags/v"),
    "qbittorrent": ("qbittorrent/qbittorrent", r"^refs/tags/release-", "refs/tags/release-"),
    "transmission": ("transmission/transmission", r"^refs/tags/[0-9]\.", "refs/tags/"),
}

# Per-OS settings: (event_poll, file_allocation, aria2c_dir, dir suffixes)
OS_SETTINGS = {
    "linux": ("epoll", "falloc", "/etc/aria2/", "cert/", "conf/", "data", "work/"),
    "macos": ("kqueue", "trunc", "/etc/aria2/", "cert/", "conf/", "data", "work/"),
    "windows": ("select", "falloc", "C:\\Program Files\\aria2\\", "cert\\", "conf\\", "data", "work\\"),
}

# aria2c options; {placeholders} are filled per software/OS combination.
# Options with an empty value (or no value) are commented out in the output.
ARIA2C_OPTIONS = (
    "all-proxy-passwd=",
    "all-proxy-user=",
    "all-proxy=",
    "allow-overwrite=true",
    "allow-piece-length-change=true",
    "always-resume=true",
    "async-dns-server=",
    "async-dns=true",
    "auto-file-renaming=false",
    "auto-save-interval=1",
    "bt-detach-seed-only=true",
    "bt-enable-hook-after-hash-check=true",
    "bt-enable-lpd=true",
    "bt-exclude-tracker={excludelist_data}",
    "bt-external-ip=",
    "bt-force-encryption=true",
    "bt-hash-check-seed=true",
    "bt-load-saved-metadata=true",
    "bt-lpd-interface=",
    "bt-max-open-files=4096",
    "bt-max-peers=0",
    "bt-metadata-only=false",
    "bt-min-crypto-level=arc4",
    "bt-piece-selector=",
    "bt-prioritize-piece=head,tail",
    "bt-remove-unselected-file=true",
    "bt-request-peer-speed-limit=125M",
    "bt-require-crypto=true",
    "bt-save-metadata=true",
    "bt-seed-unverified=false",
    "bt-stop-timeout=0",
    "bt-tracker-connect-timeout=5",
    "bt-tracker-interval=0",
    "bt-tracker-timeout=5",
    "bt-tracker={trackerlist_data}",
    "bt-udp-socks-proxy-passwd=",
    "bt-udp-socks-proxy-user=",
    "bt-udp-socks-proxy=",
    "ca-certificate=",
    "certificate=",
    "check-certificate=true",
    "check-integrity=true",
    "checksum=",
    "conditional-get=true",
    "conf-path={aria2c_dir}{aria2c_conf_dir}aria2.conf",
    "connect-timeout=5",
    "console-log-level=notice",
    "content-disposition-default-utf8=true",
    "continue=true",
    "daemon=false",
    "deferred-input=false",
    "dht-entry-point6=dht.aelitis.com:6881",
    "dht-entry-point6=dht.libtorrent.org:25401",
    "dht-entry-point6=dht.transmissionbt.com:6881",
    "dht-entry-point6=router.bittorrent.com:6881",
    "dht-entry-point6=router.silotis.us:6881",
    "dht-entry-point6=router.utorrent.com:6881",
    "dht-entry-point=dht.aelitis.com:6881",
    "dht-entry-point=dht.libtorrent.org:25401",
    "dht-entry-point=dht.transmissionbt.com:6881",
    "dht-entry-point=router.bittorrent.com:6881",
    "dht-entry-point=router.silotis.us:6881",
    "dht-entry-point=router.utorrent.com:6881",
    "dht-file-path6={aria2c_dir}{aria2c_work_dir}aria2.dht6",
    "dht-file-path={aria2c_dir}{aria2c_work_dir}aria2.dht",
    "dht-listen-addr6=",
    "dht-listen-port=6881-6889",
    "dht-message-timeout=5",
    "dir={aria2c_dir}{aria2c_data_dir}",
    "disable-ipv6=false",
    "disk-cache=0",
    "download-result=full",
    "dry-run=false",
    "dscp=32",
    "enable-async-dns6=",
    "enable-color=true",
    "enable-dht6=true",
    "enable-dht=true",
    "enable-http-keep-alive=true",
    "enable-http-pipelining=true",
    "enable-mmap=true",
    "enable-peer-exchange=true",
    "enable-rpc=true",
    "event-poll={event_poll}",
    "file-allocation={file_allocation}",
    "follow-metalink=mem",
    "follow-torrent=mem",
    "force-save=true",
    "force-sequential=true",
    "ftp-passwd=ARIA2USER@",
    "ftp-pasv=true",
    "ftp-proxy-passwd=",
    "ftp-proxy-user=",
    "ftp-proxy=",
    "ftp-reuse-connection=true",
    "ftp-type=binary",
    "ftp-user=anonymous",
    "gid=",
    "hash-check-only=false",
    "header=",
    "help",
    "http-accept-gzip=true",
    "http-auth-challenge=true",
    "http-no-cache=true",
    "http-passwd=",
    "http-proxy-passwd=",
    "http-proxy-user=",
    "http-proxy=",
    "http-user=",
    "https-proxy-passwd=",
    "https-proxy-user=",
    "https-proxy=",
    "human-readable=true",
    "index-out=",
    "input-file={aria2c_dir}{aria2c_work_dir}aria2.session",
    "interface=",
    "keep-unfinished-download-result=true",
    "listen-port=6881-6889",
    "load-cookies={aria2c_dir}{aria2c_work_dir}aria2.cookie",
    "log-level=error",
    "log={aria2c_dir}{aria2c_work_dir}aria2.log",
    "lowest-speed-limit=0",
    "max-concurrent-downloads=10",
    "max-connection-per-server=16",
    "max-download-limit=0",
    "max-download-result=10",
    "max-file-not-found=5",
    "max-mmap-limit=9223372036854775807",
    "max-overall-download-limit=0",
    "max-overall-upload-limit=0",
    "max-resume-failure-tries=0",
    "max-tries=0",
    "max-upload-limit=0",
    "metalink-base-uri=",
    "metalink-enable-unique-protocol=true",
    "metalink-file=",
    "metalink-language=",
    "metalink-location=",
    "metalink-os=",
    "metalink-preferred-protocol=https",
    "metalink-version=",
    "min-split-size=4K",
    "min-tls-version=TLSv1.2",
    "multiple-interface=",
    "netrc-path={aria2c_dir}{aria2c_work_dir}aria2.netrc",
    "no-conf=false",
    "no-file-allocation-limit=4K",
    "no-netrc=false",
    "no-proxy=",
    "no-want-digest-header=true",
    "on-bt-download-complete=",
    "on-download-complete=",
    "on-download-error=",
    "on-download-pause=",
    "on-download-start=",
    "on-download-stop=",
    "optimize-concurrent-downloads=true",
    "out=",
    "parameterized-uri=true",
    "pause-metadata=true",
    "pause=false",
    "peer-agent={peer_agent}",
    "peer-id-prefix={peer_id_prefx}",
    "piece-length=4K",
    "private-key=",
    "proxy-method=tunnel",
    "quiet=false",
    "realtime-chunk-checksum=true",
    "referer=*",
    "remote-time=true",
    "remove-control-file=true",
    "retry-on-400=",
    "retry-on-403=",
    "retry-on-406=",
    "retry-on-unknown=",
    "retry-wait=5",
    "reuse-uri=true",
    "rlimit-nofile=",
    "rpc-allow-origin-all=true",
    "rpc-certificate={aria2c_dir}{aria2c_cert_dir}fullchain.cer",
    "rpc-listen-all=true",
    "rpc-listen-port=6800",
    "rpc-max-request-size=4M",
    "rpc-passwd=",
    "rpc-private-key={aria2c_dir}{aria2c_cert_dir}zhijie.online.key",
    "rpc-save-upload-metadata=true",
    "rpc-secret=",
    "rpc-secure=false",
    "rpc-user=",
    "save-cookies={aria2c_dir}{aria2c_work_dir}aria2.cookie",
    "save-not-found=true",
    "save-session-interval=1",
    "save-session={aria2c_dir}{aria2c_work_dir}aria2.session",
    "seed-ratio=1.0",
    "seed-time=60",
    "select-file=",
    "server-stat-if={aria2c_dir}{aria2c_work_dir}aria2.stat",
    "server-stat-of={aria2c_dir}{aria2c_work_dir}aria2.stat",
    "server-stat-timeout=3600",
    "show-console-readout=true",
    "show-files=true",
    "socket-recv-buffer-size=4M",
    "split=16",
    "ssh-host-key-md=",
    "stderr=false",
    "stop-with-process=",
    "stop=0",
    "stream-piece-selector=inorder",
    "summary-interval=0",
    "timeout=5",
    "torrent-file=",
    "truncate-console-readout=true",
    "uri-selector=adaptive",
    "use-head=true",
    "user-agent=aria2/{aria2_version}",
    "version",
)


## Function
# Download one URL, return decoded text (empty string on failure, like curl -s)
def download(url):
    try:
        request = Request(url, headers={"User-Agent": "aria2.conf-build"})
        with urlopen(request, timeout=15) as response:
            return response.read().decode("utf-8", errors="replace")
    except OSError:
        return ""


# Get Trackerslist Data
def get_trackerslist_data():
    with ThreadPoolExecutor(max_workers=2) as pool:
        excludelist_data, trackerlist_data = pool.map(download, (EXCLUDELIST_URL, TRACKERLIST_URL))
    return excludelist_data.strip(), trackerlist_data.strip()


# Get Masquerade Data: latest release tag of each client
def get_masquerade_data():
    def latest(name):
        repo, pattern, prefix = MASQUERADE_REPOS[name]
        refs = json.loads(download(f"https://api.github.com/repos/{repo}/git/matching-refs/tags") or "[]")
        tags = [item["ref"] for item in refs if re.search(pattern, item["ref"])]
        if name == "deluge":
            tags = [tag for tag in tags if not re.search(r"[a-z][0-9]$", tag)]
        if name == "transmission":
            tags = [tag for tag in tags if not re.search(r"b[0-9]$", tag)]
        return tags[-1].removeprefix(prefix) if tags else ""

    with ThreadPoolExecutor(max_workers=5) as pool:
        versions = dict(zip(MASQUERADE_REPOS, pool.map(latest, MASQUERADE_REPOS)))
    return versions


# Generate Masquerade Info
def generate_masquerade_info(software_prefix, versions):
    if software_prefix == "qb":
        version = versions["qbittorrent"]
        return f"qBittorrent/{version}", f"-qB{version.replace('.', '')}0-"
    if software_prefix == "de":
        deluge, libtorrent = versions["deluge"], versions["libtorrent"]
        return f"Deluge/{deluge} libtorrent/{libtorrent}", f"-DE{deluge.replace('.', '')}s-"
    if software_prefix == "tr":
        version = versions["transmission"]
        return f"Transmission/{version}", f"-TR{version.replace('.', '')}0-"
    version = versions["aria2"]
    return f"aria2/{version}", f"A2-{version.replace('.', '-')}-"


# Output aria2c Options
def output_aria2c_options(software_prefix, os_name, versions, excludelist_data, trackerlist_data):
    event_poll, file_allocation, aria2c_dir, cert_dir, conf_dir, data_dir, work_dir = OS_SETTINGS[os_name]
    peer_agent, peer_id_prefx = generate_masquerade_info(software_prefix, versions)
    values = {
        "excludelist_data": excludelist_data,
        "trackerlist_data": trackerlist_data,
        "aria2c_dir": aria2c_dir,
        "aria2c_cert_dir": cert_dir,
        "aria2c_conf_dir": conf_dir,
        "aria2c_data_dir": data_dir,
        "aria2c_work_dir": work_dir,
        "event_poll": event_poll,
        "file_allocation": file_allocation,
        "peer_agent": peer_agent,
        "peer_id_prefx": peer_id_prefx,
        "aria2_version": versions["aria2"],
    }
    lines = []
    for template in ARIA2C_OPTIONS:
        option = template.format(**values)
        if "rpc-certificate" in option or "rpc-private-key" in option:
            lines.append(f"#{option}")
        elif "=" in option and option.rsplit("=", 1)[1]:
            lines.append(option)
        else:
            lines.append(f"#{option}")
    out_dir = ROOT / "dist" / software_prefix
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / f"{os_name}.conf").write_text("\n".join(lines) + "\n")


# Output Data
def output_data(versions, excludelist_data, trackerlist_data):
    for os_name in OS_SETTINGS:
        for software_prefix in ("a2", "de", "qb", "tr"):
            output_aria2c_options(software_prefix, os_name, versions, excludelist_data, trackerlist_data)


## Process
def main():
    excludelist_data, trackerlist_data = get_trackerslist_data()
    versions = get_masquerade_data()
    output_data(versions, excludelist_data, trackerlist_data)


if __name__ == "__main__":
    main()
