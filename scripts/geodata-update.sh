#!/bin/bash

MOSDNS_PATH=/etc/mosdns

echo "Downloading geoip.zip..."
curl --progress-bar -JL -o $MOSDNS_PATH/downloads/geoip.zip https://github.com/techprober/v2ray-rules-dat/raw/release/geoip.zip
echo "Downloading geosite.zip..."
curl --progress-bar -JL -o $MOSDNS_PATH/downloads/geosite.zip https://github.com/techprober/v2ray-rules-dat/raw/release/geosite.zip
echo "Extracting geoip.zip to ips/ ..."
unzip -qq -o $MOSDNS_PATH/downloads/geoip.zip -d $MOSDNS_PATH/ips
echo "Extracting geosite.zip to domains/ ..."
unzip -qq -o $MOSDNS_PATH/downloads/geosite.zip -d $MOSDNS_PATH/domains

echo "Finished."
