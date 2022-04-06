## This script would not be made possible if it weren't for the article over at "https://javapipe.com/iptables-ddos-protection" and for part2 "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html".

#!/bin/bash

# iptables and ssh server hardening

# Flush all rules.
/sbin/iptables -F
/sbin/iptables -X

echo "This script would not be made possible if it weren't for the article over at 'https://javapipe.com/iptables-ddos-protection', for part2 'https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html' and for part3 'https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html'."
echo
echo "Part 1."

/sbin/iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
echo "Added rule: 1. Drop invalid packets."
echo

/sbin/iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j DROP
echo "Added rule: 2. Drop TCP packets that are new and are not SYN."
echo

/sbin/iptables -t mangle -A PREROUTING -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
echo "Added rule: 3. Drop SYN packets with suspicious MSS value."
echo

/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
/sbin/iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
echo "Added rule: 4. Block packets with bogus TCP flags."
echo

# IMPORTANT: Replace your network interface, ip address and ip range here!
/sbin/iptables -A INPUT -i eth0 -s 172.16.1.10 -j
/sbin/iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j DROP
#/sbin/iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j DROP
/sbin/iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP
echo "Added rule: 5. Block spoofed packets."
echo

/sbin/iptables -t mangle -A PREROUTING -p icmp -j DROP
echo "Added rule: 6. Drop ICMP. You usually do not need this protocol."
echo

/sbin/iptables -t mangle -A PREROUTING -f -j DROP
echo "Added rule: 7. Drop fragments in all chains."
echo

/sbin/iptables -A INPUT -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset
echo "Added rule: 8. Limit connections per source IP."
echo

/sbin/iptables -A INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT
/sbin/iptables -A INPUT -p tcp --tcp-flags RST RST -j DROP
echo "Added rule: 9. Limit RST packets."
echo

/sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
/sbin/iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP
echo "Added rule: 10. Limit new TCP connections per second per source IP."
echo

# For some reason this blocks the ability to port forward.
# /sbin/iptables -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
/sbin/iptables -A INPUT -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
/sbin/iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
echo "Added rule: 11. Use SYNPROXY on all ports. Disables connection limiting rule."
echo

# Extras.
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
/sbin/iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
echo "Added rule: Extra. SSH brute-force protection."
echo

/sbin/iptables -N port-scanning
/sbin/iptables -A port-scanning -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
/sbin/iptables -A port-scanning -j DROP
echo "Added rule: Extra. Protection against port scanning."
echo

echo "Done part1."

echo 

echo "Now for part 2."
# Part 2. "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html"
/sbin/iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
echo "Added rule 1. Force SYN packets check."
echo

/sbin/iptables -A INPUT -f -j DROP
echo "Added rule 2. Force Fragments packets check."
echo

/sbin/iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP
echo "Added rule 3. Drop incoming malformed XMAS packets."
echo

/sbin/iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
echo "Added rule 3. Drop incoming malformed NULL packets."
echo

echo "Done part 2."

echo "Now for part 3."
# https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html
# dport = destination port
# sport = source port
#iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT
/sbin/iptables -A INPUT -p tcp --dports 22,80,443 -m state --state NEW,ESTABLISHED -j ACCEPT

/sbin/iptables -P INPUT DROP
/sbin/iptables -P OUTPUT DROP
/sbin/iptables -P FORWARD DROP
/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A OUTPUT -o lo -j ACCEPT

/sbin/iptables -A INPUT -j DROP
/sbin/iptables -A OUTPUT -j DROP

echo "Done part 3."
echo "Done altogether."
