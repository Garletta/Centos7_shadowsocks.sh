#!/bin/sh
#Centos 7 x86_64 shadowsocks-python.server.sh

#Add epel-release and tools
yum install -y epel-release
yum update -y  
yum install -y python-setuptools
easy_install pip
pip install --upgrade pip
pip install shadowsocks

#Input your shadowsocks server profile
Server=$(curl ifconfig.me)
echo -e "\nIt is going to deploy your shadowsocks and create the first user!"
echo "Please input the port of the first user:"
read Port
echo "Please input the password of the port:"
read Password

#Add profile of shadowsocks
echo >/etc/shadowsocks.json "{
	\"server\":\"$Server\",
	\"local_address\":\"127.0.0.1\",
	\"local_port\":1080,
	\"port_password\":{
		\"${Port}\":\"${Password}\"
	},
	\"timeout\":300,
	\"method\":\"aes-256-cfb\",
	\"fase_open\":false
}"

#Modify ssh profile
#echo >>/etc/ssh/sshd_config "Prot 22"
#systemctl restart sshd.service

#Deploy your firewalld
systemctl enable firewalld.service
systemctl enable firewalld
systemctl start firewalld
firewall-cmd --zone=public --add-port=${Port}/tcp --permanent
firewall-cmd --zone=public --add-port=${Port}/udp --permanent
firewall-cmd --reload

#boot item
echo >> /etc/rc.local "ssserver -c /etc/shadowsocks.json -d start"
ssserver -c /etc/shadowsocks.json -d start
echo "Thank you for using my script!"

