#!/bin/bash
#hostpot.sh

router_interface="eth0"
hostpot_interface="hostpot"
my_ip="192.168.28.1"
hostapd_conf="/etc/hostapd/hostapd.conf"
udhcpd_conf="/etc/udhcpd.conf"

hostapd_pid=$(ps aux | grep hostapd | grep -v grep | tr -s " " | cut -d " " -f 2)
udhcpd_pid=$(ps aux | grep udhcpd | grep -v grep | tr -s " " | cut -d " " -f 2)

if [ -n $udhcpd_pid ];
then
	kill -KILL $udhcpd_pid
fi

sleep 5


iw phy phy0 interface add $hostpot_interface type __ap
ifconfig $hostpot_interface $my_ip up

router_ip=$(ifconfig | grep -A 1 $router_interface | tail -n 1 | tr -s " " | cut -d " " -f 3)

sed -i "s/interface.*/interface ${hostpot_interface}/" $udhcpd_conf
sed -i "s/opt.*router.*/opt router ${router_ip}/" $udhcpd_conf


if [ -z $hostapd_pid ];
then
	hostapd -B $hostapd_conf
fi

udhcpd -fS & 

echo "1" > /proc/sys/net/ipv4/ip_forward

iptables --table nat --append POSTROUTING --out-interface $router_interface -j MASQUERADE

iptables --append FORWARD --in-interface $hostpot_interface -j ACCEPT

