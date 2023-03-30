# Mosdns LXC Deploy

Deploy mosdns in Proxmox LXC Container

<p align="center">
    <img src="https://custom-icon-badges.herokuapp.com/github/license/TechProber/mosdns-lxc-deploy?logo=law&color=white" alt="License"/>
    <img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FTechProber%2Fmosdns-lxc-deploy&count_bg=%235322B2&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false"/>
    <img src="https://custom-icon-badges.herokuapp.com/badge/redis-v7.0.4-red.svg?logo=redis&logoColor=white" alt="Docker">
    <img src="https://custom-icon-badges.herokuapp.com/badge/docker-v20.10-blue.svg?logo=docker&logoColor=white" alt="Docker">
    <img src="https://custom-icon-badges.herokuapp.com/github/issues-pr-closed/TechProber/mosdns-lxc-deploy?color=purple&logo=git-pull-request&logoColor=white"/>
    <img src="https://custom-icon-badges.herokuapp.com/github/last-commit/TechProber/mosdns-lxc-deploy?logo=history&logoColor=white" alt="lastcommit"/>
</p>

## Project Owner

CopyRight 2021-2022 @TechProber. All rights reserved.

Maintainer: [ Kevin Yu (@yqlbu) ](https://github.com/yqlbu)

## Related Projects

- [IrineSistiana/mosdns](https://github.com/IrineSistiana/mosdns) - A self-hosted DNS resolver
- [tteck/Proxmox](https://github.com/tteck/Proxmox) - Proxmox Helper Scripts
- [Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat) - Enhanced edition of V2Ray rules dat files, compatible with Xray-core, Shadowsocks-windows, Trojan-Go and leaf.
- [Loyalsoldier/geoip](https://github.com/Loyalsoldier/geoip) - Enhanced edition of GeoIP files for V2Ray, Xray-core, Trojan-Go, Clash and Leaf, with replaced CN IPv4 CIDR available from ipip.net, appended CIDR lists and more.

## Documentation

Mosdns Official Wiki: https://irine-sistiana.gitbook.io/mosdns-wiki/

Know DNS Providers: https://adguard-dns.io/kb/general/dns-providers/

## How to Use

Create a new directory for mosdns:

```
mkdir -p /etc/mosdns
```

### Preparation

Make sure you have the following file structure present on your host:

```
# /etc/mosdns
./
|-- cache.dump
|-- config.yml
|-- custom
|-- domains
|-- downloads
`-- ips

4 directories, 2 files
```

create sub directories

```bash
mkdir -p /etc/mosdns/{ips,domains,downloads,custom}
touch cache.dump
```

> **Note** There is a dedicated `bootstrap playbook` to automate this, [check it out](./playbooks/auto-artifact-export.yml).

### Download Binary

Download the latest mosdns binary from the [GitHub Release](https://github.com/IrineSistiana/mosdns/releases) Page

```bash
wget https://github.com/IrineSistiana/mosdns/releases/download/{VERSION}/mosdns-{PLATFORM}-{ARCH}.zip
# e.g
# wget https://github.com/IrineSistiana/mosdns/releases/download/v5.1.3/mosdns-linux-amd64.zip
unzip mosdns-linux-amd64.zip
sudo install -Dm755 mosdns /usr/bin
```

### Download Rules

Available Rules - https://github.com/techprober/v2ray-rules-dat/releases

Download and unzip the `geoip.zip` and `geosite.zip` files to `./ips/` and `./domains` respectively.

```bash
LATEST_TAG=$(curl https://api.github.com/repos/techprober/v2ray-rules-dat/releases/latest --silent |  jq -r ".tag_name)
cd /etc/mosdns
wget -O ./downloads/geoip.zip https://github.com/techprober/v2ray-rules-dat/releases/download/$LATEST_TAG/geoip.zip
wget -O ./downloads/geosite.zip https://github.com/techprober/v2ray-rules-dat/releases/download/$LATEST_TAG/geosite.zip
unzip ./downloads/geoip.zip -d ./ips
unzip ./downloads/geosite.zip -d ./domains
```

### Reset Port 53

```bash
mkdir -p /etc/systemd/resolved.conf.d

# /etc/systemd/resolved.conf.d/mosdns.conf
[Resolve]
DNS=127.0.0.1
DNSStubListener=no
```

Specifying `127.0.0.1` as DNS server address is necessary because otherwise the nameserver will be `127.0.0.53` which doesn’t work without DNSStubListener.

Activate another resolv.conf file:

```bash
sudo mv /etc/resolv.conf /etc/resolv.conf.backup
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
```

Restart DNSStubListener:

```bash
systemctl daemon-reload
systemctl restart systemd-resolved
```

### Update Configuration

Get the latest config file, namely `config-{VERSION}.yml`, from `./mosdns` folder in this repository, copy it to `/etc/mosdns`, and update params to fit your need.

### Run as Systemd Service

```bash
sudo tee /etc/systemd/system/mosdns.service <<EOF
[Unit]
Description=A DNS forwarder
ConditionFileIsExecutable=/usr/bin/mosdns

[Service]
StartLimitInterval=5
StartLimitBurst=10
ExecStart=/usr/bin/mosdns "start" "--as-service" "-d" "/etc/mosdns" "-c" "/etc/mosdns/config.yml"

Restart=always

RestartSec=120
EnvironmentFile=-/etc/sysconfig/mosdns

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mosdns --now
```

## CN Users

To enhance the ad-free feature, we've added additional `AdBlockList` to our self-managed `geoip.dat` and `geosite.dat`

Please check out more details in [TechProber/v2ray-rules-dat](https://github.com/TechProber/v2ray-rules-dat).

## Appendix

- Auto generate `geoip.txt`, `geosites.txt` (since `*.dat` are deprecated in v5) - https://github.com/techprober/v2dat

- CI (automate `*.txt export`) - https://github.com/techprober/v2ray-rules-dat/blob/master/.github/workflows/run.yml

- Available Rules - https://github.com/techprober/v2ray-rules-dat/releases
