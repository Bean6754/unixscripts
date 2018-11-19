#!/bin/ash

# uci show network
# uci set network.lan.ipaddr=192.168.1.4
# uci set network.lan.gateway=192.168.1.254
# uci set network.lan.dns=192.168.1.254
# uci commit
# /etc/init.d/network restart

opkg update
opkg install luci-ssl-openssl libuhttpd-openssl
