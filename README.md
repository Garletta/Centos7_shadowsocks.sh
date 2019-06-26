# Centos7_shadowsocks.sh

    These script can deploy your shadowsocks server on Centos 7 x86_64.

## How to use it

    The first step, you can download these four scripts into your computer.
    And then, you can use shell command `scp` to upload these scripts to your host.

* If your ssh port is not 22, you can input these two command to change it.
  * `echo >>/etc/ssh/sshd_config "Port 22"`
  * `systemctl restart sshd.service`
* Execute the first script `Centos7x86_64-ss.sh` by `./Centos7x86_64-ss.sh` to deploy your shadowsocks server.
  * You only need to enter the first port and password for the first user.
* Execute the Second script `adduser.sh` by `./adduser.sh` to create a new user.
  * You need to enter a new port and password for the new user, the script will deploy it for you.
* Execute the Third script `deleteUser.sh` by `./deleteUser.sh` to delete an old user.
  * You need to enter the port of the user to delete it.
* Execute the fourth script `bbr.sh` by `./bbr.sh` to use BBR to accelerate.
