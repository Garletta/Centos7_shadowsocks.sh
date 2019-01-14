#!/bin/bash

# delete a user of shadowsocks by its port
# Enter the port of the user

echo "************************************************"
echo "This is a script to delete a user on shadowsocks"
echo "	you can delete the user by its port"
echo "************************************************"
echo "1.Please enter its port:"
read PORT

sed -i "/\"${PORT}\"/d" /etc/shadowsocks.json
firewall-cmd --zone=public --remove-port=${PORT}/tcp --permanent
firewall-cmd --zone=public --remove-port=${PORT}/udp --permanent
firewall-cmd --reload
ssserver -c /etc/shadowsocks.json -d stop
ssserver -c /etc/shadowsocks.json -d start

echo "success to delete the user!"
