#!/bin/bash

curl -L https://mirrors.host900.com/https://raw.githubusercontent.com/snail007/goproxy/master/install_auto.sh | bash

apt install redis wget git  -y

mkdir -p /data && cd /data

git clone --depth=1 https://github.com/hiflybo/proxy2 && cd proxy

chmod +x /data/proxy/proxy

cat > /usr/lib/systemd/system/proxy.service <<EOF
[Unit]
Description=Proxy Service
After=network.target

[Service]
Type=simple
User=root
Restart=always
RestartSec=5s
StartLimitInterval=0
ExecStart=/data/proxy/proxy -f /data/proxy/proxy-api.yaml
LimitNOFILE=10485760

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now proxy

echo -e ">>> Install OK ... \n"