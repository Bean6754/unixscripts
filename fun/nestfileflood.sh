#!/bin/bash

cd ~
mkdir lol
cd lol

while(true)
do
  mkdir $[ $RANDOM % 999999999 ]
  cd $[ $RANDOM % 999999999 ]
  cd $[ $RANDOM % 999999999 ]
  cd $[ $RANDOM % 999999999 ]
  cd $[ $RANDOM % 999999999 ]
  
  echo "This is a string of text." > $[ $RANDOM % 999999999 ]
  
  cd ~/lol
done
