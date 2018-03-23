#!/bin/bash

cd ~
mkdir lol
cd lol

while(true)
do
  mkdir $[ $RANDOM % 999999999 ]
done
