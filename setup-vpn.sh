#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    echo "You can Try comand 'su root' or 'sudo -i' or 'sudo -'"
    exit 1
fi

site=https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/
apt update
apt upgrade -y
apt install curl -y
wget -P /etc https://raw.githubusercontent.com/lamtota40/vpn-server-easy/main/tools/other/banner

#install dropbear
wget $siteSSH/dropbear/setup-dropbear.sh
