#!/bin/bash

zypper addrepo --refresh http://http.download.nvidia.com/opensuse/tumbleweed NVIDIA


clear
echo On the next command, type 'a' and press enter.
sleep 2

zypper install-new-recommends
