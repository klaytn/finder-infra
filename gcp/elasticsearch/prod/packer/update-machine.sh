#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y software-properties-common git python-dev-is-python3 htop ntp jq apt-transport-https

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic

wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py