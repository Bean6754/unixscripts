## This script would not be made possible if it weren't for the articles over at "https://javapipe.com/iptables-ddos-protection", for part2 "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html" and for part3 "https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html".

#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

echo "This script would not be made possible if it weren't for the articles over at 'https://javapipe.com/iptables-ddos-protection', for part2 'https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html' and for part3 'https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html'."
sleep 2
echo

datevar=$(date +"%Y-%m-%d_%H-%M-%S")

# iptables and ssh server hardening

# Flush all rules.
mv /etc/firewalld/direct.xml /etc/firewalld/direct.xml.$datevar
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -F
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -X
# Default ruleset.
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -P INPUT ACCEPT
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -P FORWARD ACCEPT
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -P OUTPUT ACCEPT

# Log iptables.
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m limit --limit 5/min -j LOG --log-prefix "iptables-input: " --log-level 4
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -m limit --limit 5/min -j LOG --log-prefix "iptables-forward: " --log-level 4
firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -m limit --limit 5/min -j LOG --log-prefix "iptables-output: " --log-level 4

echo "Part 1."

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -m conntrack --ctstate INVALID -j DROP
echo "Added rule: 1. Drop invalid packets."
echo

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp ! --syn -m conntrack --ctstate NEW -j DROP
echo "Added rule: 2. Drop TCP packets that are new and are not SYN."
echo

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
echo "Added rule: 3. Drop SYN packets with suspicious MSS value."
echo

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags FIN,SYN FIN,SYN -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags FIN,ACK FIN -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ACK,URG URG -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ACK,FIN FIN -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ACK,PSH PSH -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ALL ALL -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ALL NONE -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ALL FIN,PSH,URG -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j DROP
firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
echo "Added rule: 4. Block packets with bogus TCP flags."
echo

### BREAKS WIFI ON LAPTOPS!
# IMPORTANT: Replace your network interface, ip address and ip range here!
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -A INPUT -i eth0 -s 127.0.0.1 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 224.0.0.0/3 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 169.254.0.0/16 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 172.16.0.0/12 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 192.0.2.0/24 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 192.168.0.0/16 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 0.0.0.0/8 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 240.0.0.0/5 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j DROP
echo "Added rule: 5. Block spoofed packets."
echo

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -p icmp -j DROP
echo "Added rule: 6. Drop ICMP. You usually do not need this protocol."
echo

firewall-cmd --permanent --direct --add-rule ipv4 mangle PREROUTING 0 -f -j DROP
echo "Added rule: 7. Drop fragments in all chains."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m connlimit --connlimit-above 111 -j REJECT --reject-with tcp-reset
echo "Added rule: 8. Limit connections per source IP."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags RST RST -j DROP
echo "Added rule: 9. Limit RST packets."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m conntrack --ctstate NEW -j DROP
echo "Added rule: 10. Limit new TCP connections per second per source IP."
echo

# For some reason this blocks the ability to port forward.
# firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0 -t raw -A PREROUTING -p tcp -m tcp --syn -j CT --notrack
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp -m tcp -m conntrack --ctstate INVALID,UNTRACKED -j SYNPROXY --sack-perm --timestamp --wscale 7 --mss 1460
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m conntrack --ctstate INVALID -j DROP
echo "Added rule: 11. Use SYNPROXY on all ports. Disables connection limiting rule."
echo

# Extras.
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
echo "Added rule: Extra. SSH brute-force protection."
echo

firewall-cmd --permanent --direct --add-chain ipv4 filter PORT-SCANNING
firewall-cmd --permanent --direct --add-rule ipv4 filter PORT-SCANNING 0 -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s --limit-burst 2 -j RETURN
firewall-cmd --permanent --direct --add-rule ipv4 filter PORT-SCANNING 0 -j DROP
echo "Added rule: Extra. Protection against port scanning."
echo

echo "Done part1."

echo 

echo "Now for part 2."
# Part 2. "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html"
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp ! --syn -m state --state NEW -j DROP
echo "Added rule 1. Force SYN packets check."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -f -j DROP
echo "Added rule 2. Force Fragments packets check."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags ALL ALL -j DROP
echo "Added rule 3. Drop incoming malformed XMAS packets."
echo

firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p tcp --tcp-flags ALL NONE -j DROP
echo "Added rule 3. Drop incoming malformed NULL packets."
echo

echo "Done part 2."

echo "Now for part 3." # Managed by firewalld!
# https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html
# dport = destination port
# sport = source port
#iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT
## Managed by Firewalld
# SSH (TCP).
firewall-cmd --permanent --zone=public --add-service=ssh
# HTTP and HTTPS (TCP).
#firewall-cmd --permanent --zone=public --add-service=http
#firewall-cmd --permanent --zone=public --add-service=https

#firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -i lo -j ACCEPT
#firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -o lo -j ACCEPT

#firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -j DROP
#firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -j ACCEPT

# Enable apt.
#firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -m state --state ESTABLISHED,RELATED -j ACCEPT

echo "Done part 3."
echo "Done altogether."

echo "Saving rules.."
systemctl restart firewalld
firewall-cmd --reload
#firewall-cmd --permanent --direct --add-rule ipv4 filter IN_public_allow 0-save > /etc/iptables/rules.v4
#/sbin/ip6tables-save > /etc/iptables/rules.v6
echo "Rules saved."
