#!/bin/sh
#Centos 7 shadowsocks-python.server.sh

#添加依赖以及更新repo
yum install -y epel-release #启用epel-release依赖
yum update -y               #更新update源
yum install -y python-pip   #安装pip包管理器
pip install --upgrade pip   #更新pip
pip install shadowsocks     #安装server

#键入配置信息
Server=$(curl ifconfig.me)
echo -e "\nPlease input your server_port:"
read Server_port
echo -e "\nPlease input your password:"
read Password

#添加配置文件
echo >/etc/shadowsocks.json "{
	\"server\":\"$Server\",
	\"server_port\":$Server_port,
	\"local_address\":\"127.0.0.1\",
	\"local_port\":1080,
	\"password\":\"$Password\",
	\"timeout\":300,
	\"method\":\"aes-256-cfb\"
}"

#修改ssh端口
echo >>/etc/ssh/sshd_config "Prot 22"
systemctl restart sshd.service

#开启防火墙以及相应端口
systemctl start firewalld
firewall-cmd --zone=public --add-port=$Server_port/tcp --permanent
firewall-cmd --zone=public --add-port=$Server_port/udp --permanent
firewall-cmd --reload

#开机执行
echo "#!/bin/sh 
ssserver -c /etc/shadowsocks.json -d start" >> /etc/rc.d/ss.sh
chmod +x /etc/rc.d/ss.sh
echo "/etc/rc.d/ss.sh" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

#开启服务
ssserver -c /etc/shadowsocks.json -d start
echo "Thank you for using my script!"

