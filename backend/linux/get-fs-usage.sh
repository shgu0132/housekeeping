#!/bin/bash
# pass fs name as parameter, default is all filesystems
df -h $1 | awk '{$1=$1}1' OFS=","
