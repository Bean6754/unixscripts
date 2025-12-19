#!/bin/sh

# Test if root and exit 1 if not root.
# Make sure only root can run our script.
if [ "$(id -u)" -ne 0 ]; then
  echo "Must be run as root." 1>&2
  exit 1
fi

## To delete PC object from AD.
#realm leave --remove --client-softwar=sssd REALM.CORP
realm leave --client-software=sssd REALM.CORP
rm -f /etc/krb5.keytab
realm join --client-software=sssd REALM.CORP
systemctl restart sssd.service
