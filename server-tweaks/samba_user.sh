#!/bin/bash

adduser --no-create-home --disabled-password --disabled-login sambauser
smbpasswd -a sambauser
gpasswd sambashare -a sambauser
