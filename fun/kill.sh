#!/bin/bash

while (true)
do
  kill $[ $RANDOM % 999999999 ]
done
exit 0
