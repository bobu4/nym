#!/usr/bin/env bash
sudo apt update -y
sudo apt install pkg-config build-essential libssl-dev curl jq git -y
rustup update
git clone https://github.com/nymtech/nym.git nym_new
cd nym_new
git checkout release/v1.1.3
cargo build --release
systemctl stop nym-mixnode
cd
rm -rf nym
mv nym_new nym
sed -i 's/1.1.2/1.1.3/g' /root/.nym/mixnodes/Drake/config/config.toml
systemctl start nym-mixnode
