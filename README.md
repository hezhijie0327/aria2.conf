# aria2.conf

[![License](https://img.shields.io/badge/License-Apache%202.0--Commons%20Clause-blue)](LICENSE)
[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)

自动生成优化的 aria2 配置（Linux / macOS / Windows），伪装为最新版 qBittorrent / Deluge / Transmission / aria2 客户端，并内置最新跟踪器列表。开发规范见 [AGENTS.md](AGENTS.md)。

## 特性

- **客户端伪装**：peer-agent / peer-id-prefix 跟随各客户端最新版本号（GitHub tags API 自动获取）
- **跟踪器集成**：自动嵌入 [Trackerslist](https://github.com/hezhijie0327/Trackerslist) 的已验证与排除列表
- **三平台适配**：Linux（epoll/falloc）、macOS（kqueue/trunc）、Windows（select/falloc）
- **四种配置档**：a2（aria2 原生）、de（Deluge）、qb（qBittorrent）、tr（Transmission）
- **Docker 安装器**：`aria2.sh` 一键拉取镜像、下载配置、启动容器
- **自动更新**：GitHub Actions 每日构建并提交

## 快速开始

### 方式一：直接使用生成的配置

```bash
# Linux + qBittorrent 伪装档
curl -O https://raw.githubusercontent.com/hezhijie0327/aria2.conf/main/dist/qb/linux.conf
```

文件路径：`dist/<配置档>/<平台>.conf`，配置档 ∈ {a2, de, qb, tr}，平台 ∈ {linux, macos, windows}。

### 方式二：本地构建

```bash
git clone https://github.com/hezhijie0327/aria2.conf.git
cd aria2.conf
python3 build.py
```

依赖：Python 3.9+（仅标准库）、网络访问。

### 方式三：Docker 部署（aria2.sh）

```bash
# 编辑 aria2.sh 顶部参数（DOCKER_PATH、DOWNLOAD_CONFIG、RPC 端口/密钥等）
bash aria2.sh
```

`aria2.sh` 会拉取 `hezhijie0327/aria2` 镜像，按 `DOWNLOAD_CONFIG`（a2/de/qb/tr）下载对应 Linux 配置，按需改写端口、RPC、IPv6 等选项后启动容器。

## 配置说明

- 空值选项与 `rpc-certificate` / `rpc-private-key` 默认注释，按需启用
- RPC 默认端口 6800，`rpc-secret` 默认注释（建议启用）
- 证书路径默认指向 `/etc/aria2/cert/`（容器内挂载 `/docker/ssl`）

## 文档

- [AGENTS.md](AGENTS.md) — 开发规范与实现细节（英文）

## License

[Apache License 2.0 with Commons Clause v1.0](LICENSE)
