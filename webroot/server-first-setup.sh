#!/usr/bin/env bash
set -e

# Install git, python3 and ansible
apt update
apt install -y git python3 python3-pip
pip3 install ansible

git clone https://git.bjphoster.com/b.pedini/server-setup.git
cd server-setup
ansible-playbook main.yml

userdel --remove $(grep "1000:1000" /etc/passwd | cut -d':' -f1)
