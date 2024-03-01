#!/bin/bash

# Create new account

unzip -o snarkos.zip
account=$(./snarkos account new)
echo "${account}"
private_key=$(echo "${account}" | grep "Private Key" | awk '{print $3}')
echo "PROVER_PRIVATE_KEY=${private_key}" >> ./private-key

# install service

cp aleo.service /lib/systemd/system/
systemctl daemon-reload
systemctl enable aleo
systemctl start aleo
