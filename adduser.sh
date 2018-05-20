#!/bin/sh

echo "This is a script to create a new user of shadowsocks!"
echo "Please input a new port to create a new user:"
read port
echo "Please input the password of the new port:"
read password

sed -i "6i\"${port}\":\"${password}\"," /etc/shadowsocks.json
firewall-cmd --zone=public --add-port=${port}/tcp --permanent
firewall-cmd --zone=public --add-port=${port}/udp --permanent
firewall-cmd --reload
ssserver -c /etc/shadowsocks.json -d restart

echo "success!"
