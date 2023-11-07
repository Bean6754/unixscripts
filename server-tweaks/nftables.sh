## This script would not be made possible if it wasn't for the articles over at "https://javapipe.com/iptables-ddos-protection", for part2 "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html" and for part3 "https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html".

#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

echo "This script would not be made possible if it weren't for the articles over at 'https://javapipe.com/iptables-ddos-protection', for part2 'https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html' and for part3 'https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html'."
sleep 2
echo

# iptables and ssh server hardening

# Delete current ruleset.
rm -rf /etc/nftables.conf

# Flush all rules.
#nft flush table ip filter
#nft delete chain ip filter (null)
# Default ruleset.
#nft flush ruleset

# Add default tables and chains.
nft 'add table ip filter'
nft 'add chain ip filter INPUT { type filter hook input priority 0; }'
nft 'add chain ip filter FORWARD { type filter hook forward priority 0; }'
nft 'add chain ip filter OUTPUT { type filter hook output priority 0; }'
nft 'add table ip nat'
nft 'add chain nat POSTROUTING { type nat hook postrouting priority 100; }'
nft 'add chain nat PREROUTING { type nat hook prerouting priority 100; }'
nft 'add table mangle'
nft 'add chain mangle POSTROUTING { type route hook output priority -150; }'
nft 'add rule mangle POSTROUTING tcp sport 80 meta priority set 1'
nft 'add chain mangle PREROUTING { type route hook output priority -150; }'
nft 'add rule mangle PREROUTING tcp sport 80 meta priority set 1'

# Log nftables.
nft 'add rule ip filter INPUT limit rate 5/minute burst 5 packets counter log prefix "nftables-input: "'
nft 'add rule ip filter FORWARD limit rate 5/minute burst 5 packets counter log prefix "nftables-forward: "'
nft 'add rule ip filter OUTPUT limit rate 5/minute burst 5 packets counter log prefix "nftables-output: "'

echo "Part 1."

nft 'add rule ip mangle PREROUTING ct state invalid counter drop'
echo "Added rule: 1. Drop invalid packets."
echo

nft 'add rule ip mangle PREROUTING tcp flags != syn / fin,syn,rst,ack ct state new counter drop'
echo "Added rule: 2. Drop TCP packets that are new and are not SYN."
echo

nft 'add rule ip mangle PREROUTING ip protocol tcp ct state new tcp option maxseg size != 536-65535 counter drop'
echo "Added rule: 3. Drop SYN packets with suspicious MSS value."
echo


nft 'add rule ip mangle PREROUTING tcp flags 0x0 / fin,syn,rst,psh,ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,syn / fin,syn counter drop'
nft 'add rule ip mangle PREROUTING tcp flags syn,rst / syn,rst counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,syn / fin,syn counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,rst / fin,rst counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin / fin,ack counter drop'
nft 'add rule ip mangle PREROUTING tcp flags urg / ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin / fin,ack counter drop'
nft 'add rule ip mangle PREROUTING tcp flags psh / psh,ack counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,syn,rst,psh,ack,urg / fin,syn,rst,psh,ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags 0x0 / fin,syn,rst,psh,ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,psh,urg / fin,syn,rst,psh,ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,syn,psh,urg / fin,syn,rst,psh,ack,urg counter drop'
nft 'add rule ip mangle PREROUTING tcp flags fin,syn,rst,ack,urg / fin,syn,rst,psh,ack,urg counter drop'
echo "Added rule: 4. Block packets with bogus TCP flags."
echo

### BREAKS LOCAL-NAT (VMs and Containers) AND WIFI ON LAPTOPS!
# IMPORTANT: Replace your network interface, ip address and ip range here!
#nft 'add rule ip filter INPUT iifname "eth0" ip saddr 172.16.1.10 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 224.0.0.0/3 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 169.254.0.0/16 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 172.16.0.0/12 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 192.0.2.0/24 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 192.168.0.0/16 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 10.0.0.0/8 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 0.0.0.0/8 counter drop'
#nft 'add rule ip mangle PREROUTING ip saddr 240.0.0.0/5 counter drop'
#nft 'add rule ip mangle PREROUTING iifname != "lo" ip saddr 127.0.0.0/8 counter drop'
echo "Added rule: 5. Block spoofed packets."
echo

#nft 'add rule ip mangle PREROUTING ip protocol icmp counter drop'
nft 'add rule ip filter INPUT icmp type echo-request limit rate 1/second burst 2 packets counter accept'
nft 'add rule ip filter INPUT ip protocol icmp counter drop'
echo "Added rule: 6. Limit ICMP. You usually do not need this protocol."
echo

nft 'add rule ip mangle PREROUTING ip frag-off & 0x1fff != 0 counter drop'
echo "Added rule: 7. Drop fragments in all chains."
echo

nft 'add set ip filter connlimit0 { type ipv4_addr; flags dynamic; }'
nft 'add rule ip filter INPUT ip protocol tcp add @connlimit0 { ip saddr ct count over 111 } counter reject with tcp reset'
echo "Added rule: 8. Limit connections per source IP."
echo

nft 'add rule ip filter INPUT tcp flags rst / rst limit rate 2/second burst 2 packets counter accept'
nft 'add rule ip filter INPUT tcp flags rst / rst counter drop'
echo "Added rule: 9. Limit RST packets."
echo

nft 'add rule ip filter INPUT ip protocol tcp ct state new limit rate 60/second burst 20 packets counter accept'
nft 'add rule ip filter INPUT ip protocol tcp ct state new counter drop'
echo "Added rule: 10. Limit new TCP connections per second per source IP."
echo

# For some reason this blocks the ability to port forward.
# nft 'add rule ip raw PREROUTING tcp flags syn / fin,syn,rst,ack counter notrack'
nft 'add rule ip filter INPUT ct state invalid,untracked counter synproxy sack-perm timestamp wscale 7 mss 1460'
nft 'add rule ip filter INPUT ct state invalid counter drop'
echo "Added rule: 11. Use SYNPROXY on all ports. Disables connection limiting rule."
echo

# Extras.
#nft # -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
#nft # -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
echo "Added rule: Extra. SSH brute-force protection."
echo

nft add chain ip filter port-scanning
nft 'add rule ip filter port-scanning tcp flags rst / fin,syn,rst,ack limit rate 1/second burst 2 packets counter return'
nft 'add rule ip filter port-scanning counter drop'
echo "Added rule: Extra. Protection against port scanning."
echo

echo "Done part1."

echo

echo "Now for part 2."
# Part 2. "https://www.cyberciti.biz/tips/linux-iptables-10-how-to-block-common-attack.html"
nft 'add rule ip filter INPUT tcp flags != syn / fin,syn,rst,ack ct state new counter drop'
echo "Added rule 1. Force SYN packets check."
echo

nft 'add rule ip filter INPUT ip frag-off & 0x1fff != 0 counter drop'
echo "Added rule 2. Force Fragments packets check."
echo

nft 'add rule ip filter INPUT tcp flags fin,syn,rst,psh,ack,urg / fin,syn,rst,psh,ack,urg counter drop'
echo "Added rule 3. Drop incoming malformed XMAS packets."
echo

nft 'add rule ip filter INPUT tcp flags 0x0 / fin,syn,rst,psh,ack,urg counter drop'
echo "Added rule 3. Drop incoming malformed NULL packets."
echo

echo "Done part 2."

echo "Now for part 3."
# https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html
# dport = destination port
# sport = source port
# nft 'add rule ip filter INPUT ip daddr $SERVER_IP tcp sport 513-65535 tcp dport 22 ct state new,established counter accept'
# nft 'add rule ip filter OUTPUT ip saddr $SERVER_IP tcp sport 22 tcp dport 513-65535 ct state established counter accept'
# SSH (TCP).
nft 'add rule ip filter INPUT tcp dport 22 ct state new,established counter accept'
# HTTP/HTTPS (TCP).
nft 'add rule ip filter INPUT ip protocol tcp tcp dport { 80, 443 } ct state new,established counter accept'

nft 'add rule ip filter INPUT iifname "lo" counter accept'
nft 'add rule ip filter OUTPUT oifname "lo" counter accept'

# Set 'INPUT' to 'accept' instead of 'drop' and enable FORWARD to 'accept' if you are setting-up a router.
nft 'add rule ip filter INPUT counter drop'
#nft 'add rule ip filter FORWARD counter accept'
nft 'add rule ip filter OUTPUT counter accept'

# Enable apt.
nft 'insert rule ip filter INPUT ct state related,established counter accept'

echo "Done part 3."
echo "Done altogether."

echo "Saving rules.."
nft list ruleset > /etc/nftables.conf
echo "Rules saved."
