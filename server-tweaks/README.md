## Recommended actions when first setting up server/LXC-container.
### Set static-IP by:
```
nmcli conn modify 'System eth0' ipv4.addresses 172.16.1.20/18
nmcli conn modify 'System eth0' ipv4.gateway 172.16.0.1
nmcli conn modify 'System eth0' ipv4.dns 172.16.0.1
nmcli conn modify 'System eth0' ipv4.dns-search home

nmcli conn up 'System eth0'
nmcli conn down 'System eth0'
nmcli net off
nmcli net on
```

### Create `/etc/ssh/sshd_config` and `/etc/ssh/banner` from `server-tweaks - etc/ssh/sshd_config` from `server-tweaks - etc/ssh/banner`

### Create `/etc/sysctl.d/custom.conf` from `server-tweaks - etc/sysctl.d/custom.conf`

### Run `# bash /root/firewalld.sh`

### Install and enable fail2ban.
