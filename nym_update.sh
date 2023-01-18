#!/usr/bin/env bash
sudo apt update -y
sudo apt install pkg-config build-essential libssl-dev curl jq git -y
rustup update
git clone https://github.com/nymtech/nym.git nym_new
cd nym_new
version=$(git tag | grep -e "nym-binaries" | tail -1 | cut -d "v"   -f2)
git checkout release/v"$version"
cargo build --release
systemctl stop nym-mixnode
cd
rm -rf nym
mv nym_new nym
sed -i 's/'"$1"'/'"$version"'/g' /root/.nym/mixnodes/Drake/config/config.toml
systemctl start nym-mixnode
