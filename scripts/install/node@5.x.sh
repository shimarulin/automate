#!/usr/bin/env bash
apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
apt-get install -y nodejs build-essential