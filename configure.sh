#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/XTLS/Xray-core/releases/download/v1.3.1/Xray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/xray /usr/local/bin/xray

# Remove temporary directory
rm -rf /tmp/v2ray

# xRay new configuration
install -d /usr/local/etc/xray
cat << EOF > /usr/local/etc/xray/config.json
{"inbounds":[{"port":"$PORT","protocol":"vmess","settings":{"clients":[{"id":"$UUID","alterId":64}],"disableInsecureEncryption":true},"streamSettings":{"network":"ws","wsSettings":{"path":"/phpmyadmin"}},"mux":{"enabled":false,"concurrency":0}}],"outbounds":[{"protocol":"freedom"}]}
EOF

# Run xRay
/usr/local/bin/xray run -config /usr/local/etc/xray/config.json
