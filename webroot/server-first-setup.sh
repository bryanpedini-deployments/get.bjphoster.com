#!/usr/bin/env bash
set -e

# Check operating system
PKG_APT=$(command -v apt | cat)
PKG_YUM=$(command -v yum | cat)
if [ ! -z $PKG_APT ]; then
  os_debian=true
elif [ ! -z $PKG_YUM ]; then
  os_rhel=true
fi

# Install git, python3 and ansible
if [ "$os_debian" = true ]; then
  apt update
  apt install -y git python3 python3-pip
elif [ "$os_rhel" = true ]; then
  yum install -y git python3 python3-pip
fi
pip3 install ansible

git clone https://git.bjphoster.com/b.pedini/server-setup.git
cd server-setup
ansible-playbook main.yml
cd ..

# Delete the default user if it's present
DEFAULTUSER=$(grep "1000:1000" /etc/passwd | cat | cut -d':' -f1)
if [ ! -z $DEFAULTUSER ]; then
  userdel --remove $DEFAULTUSER
fi
rm -rf server-setup
