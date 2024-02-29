#!/bin/bash

# Uninstall Aliyun services

curl -L http://update.aegis.aliyun.com/download/uninstall.sh | bash
curl -L http://update.aegis.aliyun.com/download/quartz_uninstall.sh | bash

pkill aliyun-service
rm -rf /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/sbin/aliyun*
rm -rf /etc/systemd/system/aliyun.service
rm -rf /usr/local/aegis*

/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 stop && \
/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 uninstall && \
rm -rf /usr/local/cloudmonitor

# Create new account

account=$(./snarkos account new)
echo "${account}"
private_key=$(echo "${account}" | grep "Private Key" | awk '{print $3}')
echo "PROVER_PRIVATE_KEY=${private_key}" > ./private-key
source ~/.bashrc

# install service

unzip -o snarkos.zip
cp aleo.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable aleo
systemctl start aleo
