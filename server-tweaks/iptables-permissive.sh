#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

## INFORMATION ##
# This firewall will allow all traffic in, forward and out.
# But will rate-limit, log traffic, allow only minimal ICMP and block port-scanning.

IPTABLES=/sbin/iptables
IP6TABLES=/sbin/ip6tables
IPTABLESSAVE=/sbin/iptables-save
IP6TABLESSAVE=/sbin/ip6tables-save
IPTABLESRESTORE=/sbin/iptables-restore
IP6TABLESRESTORE=/sbin/ip6tables-restore
IPTABLESRULES=/etc/iptables/rules.v4
IP6TABLESRULES=/etc/iptables/rules.v6

### IPv4.
# Reset entire ruleset before running script.
# Flush all rules.
$IPTABLES -Z
$IPTABLES -F
$IPTABLES -X
# Default ruleset.
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT
$IPTABLES -P OUTPUT ACCEPT
# Default tableset.
$IPTABLES -t nat -F
$IPTABLES -t mangle -F
# Re-flush all rules.
$IPTABLES -Z
$IPTABLES -F
$IPTABLES -X

$IPTABLES -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables-input: " --log-level 4
$IPTABLES -A FORWARD -m limit --limit 5/min -j LOG --log-prefix "iptables-forward: " --log-level 4
$IPTABLES -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "iptables-output: " --log-level 4

#ICMP traffic
echo "Creating icmp chain"
$IPTABLES -N icmp_allowed
$IPTABLES -F icmp_allowed
$IPTABLES -A icmp_allowed -m limit --limit 5/min -m state --state ESTABLISHED,RELATED -p icmp --icmp-type any -j ACCEPT
$IPTABLES -A icmp_allowed -p icmp --icmp-type \
  time-exceeded -j DROP
$IPTABLES -A icmp_allowed -p icmp --icmp-type \
  destination-unreachable -j DROP
$IPTABLES -A icmp_allowed -p icmp -j LOG --log-prefix "ICMP traffic:"
$IPTABLES -A icmp_allowed -p icmp -j ACCEPT


#Catch portscanners
echo "Creating portscan detection chain"
$IPTABLES -N check-flags
$IPTABLES -F check-flags
$IPTABLES -A check-flags -p tcp --tcp-flags ALL FIN,URG,PSH -m limit \
    --limit 5/minute -j LOG --log-level alert --log-prefix "NMAP-XMAS:"
$IPTABLES -A check-flags -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
$IPTABLES -A check-flags -p tcp --tcp-flags ALL ALL -m limit --limit \
    5/minute -j LOG --log-level 1 --log-prefix "XMAS:"
$IPTABLES -A check-flags -p tcp --tcp-flags ALL ALL -j DROP
$IPTABLES -A check-flags -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG \
    -m limit --limit 5/minute -j LOG --log-level 1 --log-prefix "XMAS-PSH:"
$IPTABLES -A check-flags -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
$IPTABLES -A check-flags -p tcp --tcp-flags ALL NONE -m limit \
    --limit 5/minute -j LOG --log-level 1 --log-prefix "NULL_SCAN:"
$IPTABLES -A check-flags -p tcp --tcp-flags ALL NONE -j DROP
$IPTABLES -A check-flags -p tcp --tcp-flags SYN,RST SYN,RST -m limit \
    --limit 5/minute -j LOG --log-level 5 --log-prefix "SYN/RST:"
$IPTABLES -A check-flags -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
$IPTABLES -A check-flags -p tcp --tcp-flags SYN,FIN SYN,FIN -m limit \
    --limit 5/minute -j LOG --log-level 5 --log-prefix "SYN/FIN:"
$IPTABLES -A check-flags -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP


$IPTABLES -A INPUT -p icmp -j icmp_allowed
$IPTABLES -A INPUT -j check-flags
$IPTABLES -A INPUT -i lo -j ACCEPT

$IPTABLES -A FORWARD -p icmp -j icmp_allowed
$IPTABLES -A FORWARD -j check-flags
$IPTABLES -A FORWARD -o lo -j ACCEPT

$IPTABLES -A OUTPUT -p icmp -j icmp_allowed
$IPTABLES -A OUTPUT -j check-flags
$IPTABLES -A OUTPUT -o lo -j ACCEPT

### IPv6.
echo "Disable IPv6"
$IP6TABLES -Z
$IP6TABLES -F
$IP6TABLES -X
$IP6TABLES -P INPUT DROP
$IP6TABLES -P FORWARD DROP
$IP6TABLES -P OUTPUT DROP

# Save rules.
$IPTABLESSAVE > $IPTABLESRULES
$IP6TABLESSAVE > $IP6TABLESRULES
