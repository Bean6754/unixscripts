#!/bin/bash

cd ~
mkdir lol
cd lol

while(true)
do
  echo "This is a string of text." > $[ $RANDOM % 999999999 ]
done
