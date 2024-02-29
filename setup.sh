#!/bin/bash

# Uninstall Aliyun services

curl -L http://update.aegis.aliyun.com/download/uninstall.sh | bash
curl -L http://update.aegis.aliyun.com/download/quartz_uninstall.sh | bash

sudo pkill aliyun-service
sudo rm -rf /etc/init.d/agentwatch /usr/sbin/aliyun-service
sudo rm -rf /usr/sbin/aliyun*
sudo rm -rf /etc/systemd/system/aliyun.service
sudo rm -rf /usr/local/aegis*

/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 stop && \
/usr/local/cloudmonitor/CmsGoAgent.linux-amd64 uninstall && \
rm -rf /usr/local/cloudmonitor

# Create new account

account=$(./snarkos account new)
echo echo "${account}"
private_key=$(echo "${account}" | grep "Private Key" | awk '{print $3}')
echo "PROVER_PRIVATE_KEY=${private_key}" > ./private-key
source ~/.bashrc

# install service

unzip -o snarkos.zip
sudo cp aleo.service /lib/systemd/system/
sudo setcap CAP_NET_BIND_SERVICE=+eip /root/aleo-boot/snarkos
sudo systemctl enable aleo
sudo systemctl start aleo
