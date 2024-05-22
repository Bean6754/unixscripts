#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# Source: https://wiki.gentoo.org/wiki/Security_Handbook/Firewalls_and_Network_Security
echo "Source: https://wiki.gentoo.org/wiki/Security_Handbook/Firewalls_and_Network_Security"
IPTABLES=/sbin/iptables
IP6TABLES=/sbin/ip6tables
IPTABLESSAVE=/sbin/iptables-save
IPTABLESRESTORE=/sbin/iptables-restore
FIREWALL=/etc/firewall.rules
DNS1=10.44.100.10
DNS2=10.44.100.18
#inside
IIP=10.44.103.180
IINTERFACE=eth0
LOCAL_NETWORK=10.44.100.0/22
#outside
#OIP=217.157.156.144
#OINTERFACE=eth1

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

  echo "Disable IPv6"
  $IP6TABLES -Z
  $IP6TABLES -F
  $IP6TABLES -X
  $IP6TABLES -P INPUT DROP
  $IP6TABLES -P FORWARD DROP
  $IP6TABLES -P OUTPUT DROP

  echo "Logging"
  # Log iptables.
  $IPTABLES -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables-input: " --log-level 4
  $IPTABLES -A FORWARD -m limit --limit 5/min -j LOG --log-prefix "iptables-forward: " --log-level 4
  $IPTABLES -A OUTPUT -m limit --limit 5/min -j LOG --log-prefix "iptables-output: " --log-level 4

  echo "Setting default rule to drop"
  $IPTABLES -P FORWARD DROP
  $IPTABLES -P INPUT   DROP
  $IPTABLES -P OUTPUT  DROP

  #default rule
  echo "Creating states chain"
  $IPTABLES -N allowed-connection
  $IPTABLES -F allowed-connection
  $IPTABLES -A allowed-connection -m state --state ESTABLISHED,RELATED -j ACCEPT
  $IPTABLES -A allowed-connection -i $IINTERFACE -m limit -j LOG --log-prefix \
      "Bad packet from ${IINTERFACE}:"
  $IPTABLES -A allowed-connection -j DROP

  #ICMP traffic
  echo "Creating icmp chain"
  $IPTABLES -N icmp_allowed
  $IPTABLES -F icmp_allowed
  $IPTABLES -A icmp_allowed -m state --state NEW -p icmp --icmp-type \
      time-exceeded -j ACCEPT
  $IPTABLES -A icmp_allowed -m state --state NEW -p icmp --icmp-type \
      destination-unreachable -j ACCEPT
  $IPTABLES -A icmp_allowed -p icmp -j LOG --log-prefix "Bad ICMP traffic:"
  $IPTABLES -A icmp_allowed -p icmp -j DROP

  #Incoming traffic
  echo "Creating incoming ssh traffic chain"
  ## SSH.
  $IPTABLES -N allow-ssh-traffic-in
  $IPTABLES -F allow-ssh-traffic-in
  #Flood protection
  $IPTABLES -A allow-ssh-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL RST --dport ssh -j ACCEPT
  $IPTABLES -A allow-ssh-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL FIN --dport ssh -j ACCEPT
  $IPTABLES -A allow-ssh-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL SYN --dport ssh -j ACCEPT
  $IPTABLES -A allow-ssh-traffic-in -m state --state RELATED,ESTABLISHED -p tcp --dport ssh -j ACCEPT
  ## Samba.
  $IPTABLES -N allow-samba-traffic-in
  $IPTABLES -F allow-samba-traffic-in
  # Flood protection.
  # TCP.
  $IPTABLES -A allow-samba-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL RST -m multiport --dports 139,445 -j ACCEPT
  $IPTABLES -A allow-samba-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL FIN -m multiport --dports 139,445 -j ACCEPT
  $IPTABLES -A allow-samba-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL SYN -m multiport --dports 139,445 -j ACCEPT
  $IPTABLES -A allow-samba-traffic-in -m state --state RELATED,ESTABLISHED -p tcp -m multiport --dports 139,445 -j ACCEPT
  # UDP.
  $IPTABLES -A allow-samba-traffic-in -m limit --limit 1/second -p udp -m multiport --dports 137,138 -j ACCEPT
  #$IPTABLES -A allow-samba-traffic-in -m state --state RELATED,ESTABLISHED -p udp -m multiport --dports 137,138 -j ACCEPT
  ## SMTP.
  $IPTABLES -N allow-smtp-traffic-in
  $IPTABLES -F allow-smtp-traffic-in
  # Flood protection.
  # TCP.
  $IPTABLES -A allow-smtp-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL RST --dport 25 -j ACCEPT
  $IPTABLES -A allow-smtp-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL FIN --dport 25 -j ACCEPT
  $IPTABLES -A allow-smtp-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL SYN --dport 25 -j ACCEPT
  $IPTABLES -A allow-smtp-traffic-in -m state --state RELATED,ESTABLISHED -p tcp --dport 25 -j ACCEPT
  ## Syslog.
  $IPTABLES -N allow-syslog-traffic-in
  $IPTABLES -F allow-syslog-traffic-in
  # Flood protection.
  # TCP.
  $IPTABLES -A allow-syslog-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL RST --dport 514 -j ACCEPT
  $IPTABLES -A allow-syslog-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL FIN --dport 514 -j ACCEPT
  $IPTABLES -A allow-syslog-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL SYN --dport 514 -j ACCEPT
  $IPTABLES -A allow-syslog-traffic-in -m state --state RELATED,ESTABLISHED -p tcp --dport 514 -j ACCEPT
  # UDP.
  $IPTABLES -A allow-syslog-traffic-in -m limit --limit 1/second -p udp --dport 514 -j ACCEPT
  #$IPTABLES -A allow-syslog-traffic-in -m state --state RELATED,ESTABLISHED -p udp --dport 514 -j ACCEPT
  ## Web.
  $IPTABLES -N allow-www-traffic-in
  $IPTABLES -F allow-www-traffic-in
  # Flood protection.
  $IPTABLES -A allow-www-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL RST -m multiport --dports 80,443 -j ACCEPT
  $IPTABLES -A allow-www-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL FIN -m multiport --dports 80,443 -j ACCEPT
  $IPTABLES -A allow-www-traffic-in -m limit --limit 1/second -p tcp --tcp-flags \
      ALL SYN -m multiport --dports 80,443 -j ACCEPT
  $IPTABLES -A allow-www-traffic-in -m state --state RELATED,ESTABLISHED -p tcp -m multiport --dports 80,443 -j ACCEPT

  #outgoing traffic
  echo "Creating outgoing ssh traffic chain"
  $IPTABLES -N allow-ssh-traffic-out
  $IPTABLES -F allow-ssh-traffic-out
  $IPTABLES -A allow-ssh-traffic-out -p tcp --dport ssh -j ACCEPT

  echo "Creating outgoing dns traffic chain"
  $IPTABLES -N allow-dns-traffic-out
  $IPTABLES -F allow-dns-traffic-out
  $IPTABLES -A allow-dns-traffic-out -p udp -d $DNS1 --dport domain \
      -j ACCEPT
  $IPTABLES -A allow-dns-traffic-out -p udp -d $DNS2 --dport domain \
     -j ACCEPT

  echo "Creating outgoing http/https traffic chain"
  $IPTABLES -N allow-www-traffic-out
  $IPTABLES -F allow-www-traffic-out
  $IPTABLES -A allow-www-traffic-out -p tcp --dport www -j ACCEPT
  $IPTABLES -A allow-www-traffic-out -p tcp --dport https -j ACCEPT

  echo "Creating outgoing rsync traffic chain"
  $IPTABLES -N allow-rsync-traffic-out
  $IPTABLES -F allow-rsync-traffic-out
  $IPTABLES -A allow-rsync-traffic-out -p tcp --dport 873 -j ACCEPT

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

  # Apply and add invalid states to the chains
  echo "Applying chains to INPUT"
  $IPTABLES -A INPUT -m state --state INVALID -j DROP
  $IPTABLES -A INPUT -p icmp -j icmp_allowed
  $IPTABLES -A INPUT -j check-flags
  $IPTABLES -A INPUT -i lo -j ACCEPT
  $IPTABLES -A INPUT -j allow-ssh-traffic-in
  $IPTABLES -A INPUT -j allow-www-traffic-in
  $IPTABLES -A INPUT -j allow-samba-traffic-in
  $IPTABLES -A INPUT -j allow-smtp-traffic-in
  $IPTABLES -A INPUT -j allow-syslog-traffic-in
  $IPTABLES -A INPUT -j allowed-connection

  # For router.
  #echo "Applying chains to FORWARD"
  #$IPTABLES -A FORWARD -m state --state INVALID -j DROP
  #$IPTABLES -A FORWARD -p icmp -j icmp_allowed
  #$IPTABLES -A FORWARD -j check-flags
  #$IPTABLES -A FORWARD -o lo -j ACCEPT
  #$IPTABLES -A FORWARD -j allow-ssh-traffic-in
  #$IPTABLES -A FORWARD -j allow-www-traffic-out
  #$IPTABLES -A FORWARD -j allowed-connection

  echo "Applying chains to OUTPUT"
  $IPTABLES -A OUTPUT -m state --state INVALID -j DROP
  $IPTABLES -A OUTPUT -p icmp -j icmp_allowed
  $IPTABLES -A OUTPUT -j check-flags
  $IPTABLES -A OUTPUT -o lo -j ACCEPT
  $IPTABLES -A OUTPUT -j allow-ssh-traffic-out
  $IPTABLES -A OUTPUT -j allow-dns-traffic-out
  $IPTABLES -A OUTPUT -j allow-www-traffic-out
  $IPTABLES -A OUTPUT -j allow-rsync-traffic-out
  $IPTABLES -A OUTPUT -j allowed-connection

  #Allow client to route through via NAT (Network Address Translation)
  # For router.
  #$IPTABLES -t nat -A POSTROUTING -o $OINTERFACE -j MASQUERADE
