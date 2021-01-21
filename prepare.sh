#!/usr/bin/bash

set -x

echo "--- Installing yarn ---"
apt update && apt -y upgrade && apt install -y curl gnupg binutils
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update
# skip interactive promts for tzdata dependency
DEBIAN_FRONTEND=noninteractive apt-get -y install yarn

echo "--- Installing dependencies ---"
yarn install

echo "--- Getting element-web from archive ---"
yarn run fetch --importkey
yarn run fetch --cfgdir ''

echo "--- Creating deb and snap ---"
yarn build:linux
