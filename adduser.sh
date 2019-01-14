#!/bin/bash
# Create a new user of shadowsocsks
# Enter the new port and password

echo "*****************************************************"
echo "This is a script to create a new user of shadowsocks!"
echo "	# Two step to create it #"
echo "	1.Enter a new port."
echo "	2.Enter a new password."
echo "*****************************************************"

echo "1.Please enter a new port to create a new user:"
read PORT
echo "2.Please enter the password of the new port:"
read PASSWORD

sed -i "/\"port_password\":{/a\		\"${PORT}\":\"${PASSWORD}\"," /etc/shadowsocks.json
firewall-cmd --zone=public --add-port=${PORT}/tcp --permanent
firewall-cmd --zone=public --add-port=${PORT}/udp --permanent
firewall-cmd --reload
ssserver -c /etc/shadowsocks.json -d stop
ssserver -c /etc/shadowsocks.json -d start

echo "success to create the new user!"
