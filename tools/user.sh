#!/bin/bash

echo "==================================="
read -p "input username     : " Login
read -p "input password     : " Pass
read -p "Expired (day)      : " exp

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

useradd -e `date -d "$exp days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null

expdate="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"

echo -e "==============================="
echo -e "Thank You For Using Our Services"
echo -e "SSH & OpenVPN Account Info"
echo -e "Username       : $Login "
echo -e "Password       : $Pass"
echo -e "==============================="
echo -e "Domain         : "
echo -e "Host           : "
echo -e "OpenSSH        : "
echo -e "Dropbear       : "
echo -e "SSL/TLS        : "
echo -e "Port Suid      : "
echo -e "Port Websocket : "
echo -e "OpenVPN        : TCP ovpn http://localhost:81/client-tcp-1194.ovpn"
echo -e "OpenVPN        : UDP ovpn2 http://localhost:81/client-udp-2200.ovpn"
echo -e "OpenVPN        : SSL 442 http://localhost:81/client-tcp-ssl.ovpn"
echo -e "badvpn         : 7100-7300"
echo -e "==============================="
echo -e "PAYLOAD"                                                          
echo -e "GET / HTTP/1.1[crlf]Host: domain[crlf]Connection: Keep-Alive[crlf]User-Agent: [ua][crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================="
echo -e "SETING HOST SSH"               
echo -e "host:port@Login:Pass"
echo -e "==============================="
echo -e "Script Install  : "
echo -e "Expired On      : $expdate"
echo -e "==============================="
