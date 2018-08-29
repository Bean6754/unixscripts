#!/bin/bash

sudo chmod 666 /dev/ttyUSB0
cu -l /dev/ttyUSB0 -s 9600
# screen /dev/ttyUSB0 9600
