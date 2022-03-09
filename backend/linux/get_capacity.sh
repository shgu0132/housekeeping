#!/bin/bash

dirPath=$1
capacity=`df -H $dirPath | grep / | awk '{print $2}'`
echo "Capacity;$capacity"
