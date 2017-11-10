#!/bin/sh
ln -s /target/usr/bin/curl /usr/bin
ln -s /target/usr/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu/
ln -s /target/usr/sbin/dmidecode /usr/sbin/
ln -s /target/lib/x86_64-linux-gnu/* /lib/x86_64-linux-gnu/
sed -i 's/without-password/yes/' /target/etc/ssh/sshd_config

_sn=`dmidecode -s system-serial-number`

curl -H "Content-Type: application/json" -X POST -d "{\"Sn\":\"$_sn\",\"Title\":\"配置主机名和网络\",\"InstallProgress\":0.8,\"InstallLog\":\"Y29uZmlnIG5ldHdvcmsK\"}" http://{{ server }}/api/osinstall/v1/report/deviceInstallInfo

curl -o /networkinfo "http://{{ server }}/api/osinstall/v1/device/getNetworkBySn?sn=$_sn&type=raw"&&chmod +x /networkinfo&& . networkinfo

#echo -e "auto lo\niface lo inet loopback\nauto eth0\niface eth0 inet static\naddress $IPADDR\nnetmask 255.255.255.0\ngateway $GATEWAY\ndns-nameservers 114.114.114.114 8.8.4.4" > /target/etc/network/interfaces
echo -e "auto lo\niface lo inet loopback\nauto eth0\niface eth0 inet static\naddress $IPADDR\nnetmask $NETMASK\ngateway $GATEWAY\ndns-nameservers 114.114.114.114 8.8.4.4" > /target/etc/network/interfaces

cp /target/etc/network/interfaces /etc/network/interfaces

echo "$HOSTNAME" > /target/etc/hostname

#sed -i 's/$vt_handoff/rootdelay=90/' /target/boot/grub/grub.cfg

#sed -i 's/$vt_handoff/rootdelay=90/' /boot/grub/grub.cfg

curl -H "Content-Type: application/json" -X POST -d "{\"Sn\":\"$_sn\",\"Title\":\"安装完成\",\"InstallProgress\":1,\"InstallLog\":\"aW5zdGFsbCBmaW5pc2hlZAo=\"}" http://{{ server }}/api/osinstall/v1/report/deviceInstallInfo

