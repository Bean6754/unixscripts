#!/bin/bash

# Requires dos2unix.

find . -iname "*.txt" -depth | xargs dos2unix -f
