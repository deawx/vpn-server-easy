#!/bin/bash

echo "==================================="
read -p "input username     : " username
read -p "input password     : " password

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
#useradd -s /bin/false -M kolam
#passwd kolam
useradd -s /bin/false -p $pass -M username

echo "selesai"
