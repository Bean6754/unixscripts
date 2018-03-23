#!/bin/bash

clear
cat /dev/urandom | padsp tee /dev/audio > /dev/null
