#!/bin/sh
#Centos 7 shadowsocks-python.server.sh

#add epel-release
yum install -y epel-release
yum update -y  
yum install -y python-setuptools
easy_install -y pip
pip install --upgrade pip
pip install shadowsocks

#input your shadowsocks server information
Server=$(curl ifconfig.me)
echo -e "\nPlease input your server_port of shadowsocks:"
read Server_port
echo -e "\nPlease input your password of shadowsocks:"
read Password

#add configuration file
echo >/etc/shadowsocks.json "{
	\"server\":\"$Server\",
	\"server_port\":$Server_port,
	\"local_address\":\"127.0.0.1\",
	\"local_port\":1080,
	\"password\":\"$Password\",
	\"timeout\":300,
	\"method\":\"aes-256-cfb\",
	\"fase_open\":false
}"

#modify ssh port
echo >>/etc/ssh/sshd_config "Prot 22"
systemctl restart sshd.service

#open firewalld and public server_port
systemctl start firewalld
firewall-cmd --zone=public --add-port=$Server_port/tcp --permanent
firewall-cmd --zone=public --add-port=$Server_port/udp --permanent
firewall-cmd --reload

#boot item
echo >> /etc/rc.local "ssserver -c /etc/shadowsocks.json -d start"
ssserver -c /etc/shadowsocks.json -d start
echo -e "\nThank you for using my script!\n"

