#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

chown -R isabella:isabella /home/isabella/
chown -R <user2>:<user2> /home/<user2>/

chmod -R 700 /home/isabella/
chmod -R 500 /home/<user2>/

chmod 700 /home/isabella/.ssh/
chmod 644 /home/isabella/.ssh/authorized_keys
#chmod 600 ~/.ssh/id_rsa

chmod 500 /home/<user2>/.ssh/
chmod 444 /home/<user2>/.ssh/authorized_keys
#chmod 600 ~/.ssh/id_rsa


# <user2> restrictions.

## .bin/
rm -rf /home/<user2>/.bin
mkdir -p /home/<user2>/.bin
ln -s /bin/cat /home/<user2>/.bin/cat
ln -s /usr/bin/clear /home/<user2>/.bin/clear
ln -s /bin/ls /home/<user2>/.bin/ls
ln -s /bin/rbash /home/<user2>/.bin/rbash
ln -s /usr/bin/sudo /home/<user2>/.bin/sudo
ln -s /usr/local/bin/update.sh /home/<user2>/.bin/update.sh
chsh -s /home/<user2>/.bin/rbash <user2>

rm -rf /home/<user2>/.bashrc
mkdir -p /var/log/nomail-update
touch /home/<user2>/.bash_history
chown <user2>:<user2> /home/<user2>/.bash_history
chmod 600 /home/<user2>/.bash_history
rm -f /var/log/nomail-update/bash_<user2>
ln -s /home/<user2>/.bash_history /var/log/nomail-update/bash_<user2>

## .bash_profile
cat <<EOF >/home/<user2>/.bash_profile
export PATH=/home/<user2>/.bin/
export TMOUT=600
export HISTSIZE=2000
export HISTTIMEFORMAT="%T %F  "
alias update="sudo /usr/local/bin/update.sh"
clear
cat ~/README.txt
EOF

## README.txt
cat <<EOF > /home/<user2>/README.txt
_
  +--------------------------------------+
  |  Run 'update' to update the system.  |
  |     Auto logout in 10 minutes.       |
  +--------------------------------------+
_
EOF
