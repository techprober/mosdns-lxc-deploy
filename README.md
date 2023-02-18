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

## Project structure

```
./
|-- cache.dump
|-- config.yml
|-- custom
|-- domains
|-- downloads
`-- ips

4 directories, 2 files
```

## Documentation

Mosdns Official Wiki: https://irine-sistiana.gitbook.io/mosdns-wiki/

## How to Use

Please checkout the [blog post](https://www.hikariai.net/blog/26-mosdns-the-next-generation-dns-resolver/#sample-configuration) to know more in details.

## CN Users

To enhance the ad-free feature, we've added additional `AdBlockList` to our self-managed `geoip.dat` and `geosite.ip`

Please check out more details in [TechProber/v2ray-rules-dat](https://github.com/TechProber/v2ray-rules-dat).

## Appendix

- Auto generate `geoip.txt`, `geosites.txt` (since `*.dat` are deprecated in v5) - https://github.com/techprober/v2dat

- CI (automate `*.txt export`) - https://github.com/techprober/v2ray-rules-dat/blob/master/.github/workflows/run.yml

- Available Rules - https://github.com/techprober/v2ray-rules-dat/releases
