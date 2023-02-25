#!/bin/bash

if [ ! $(which virt-what) ]; then
   apt install virt-what -y
fi
clear
ram_use=$(free -h | grep Mem | awk '{print $3}')
public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls "http://ip1.dynupdate.no-ip.com/")")
private_ip=$(ip -4 addr | grep inet | grep -vE '127(\.[0-9]{1,3}){3}' | cut -d '/' -f 1 | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | sed -n "$ip_number"p)
cekip= $(wget https://proxycheck.io/v2/$public_ip?vpn=1&asn=1 -q -O -)

echo "========= Time on server ========="
echo "Time =" `date "+%H:%M:%S"`
echo "Date =" `date "+%d/%m/%y"`
echo "Uptime =" `uptime -p`

echo "========= Detail server ========="
echo "Hostname = $HOSTNAME"
echo "Ip Public = $public_ip"
echo "Ip Private = $private_ip"
echo "ISP = | City= | Country="
echo "Virtualization = " `if grep -Eoc '(vmx|svm)' /proc/cpuinfo; then echo "(enable)"; else echo "(disable)"; fi`
echo "Architecture = $(uname -m)"
echo "OS = " `awk -F= '$1=="VERSION" { print $2 ;}' /etc/os-release`
echo "CPU = "
echo "RAM Usage = $ram_use | Free = Mb | Total = Mb"
echo "HHD Usage = Mb | Free = Mb | Total = Mb"
echo "=================================="
echo "ok"
