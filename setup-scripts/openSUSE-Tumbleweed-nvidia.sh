#!/bin/bash

zypper addrepo --refresh http://http.download.nvidia.com/opensuse/tumbleweed NVIDIA

clear
echo On the next command, type 'a' and press enter.
echo Then on the licensing pages press 'q', then type yes. Twice!
sleep 4

zypper install-new-recommends
