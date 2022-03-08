#!/bin/bash
dirPath=$1
level=$2

./get_capacity.sh $dirPath
echo Path,ItemType,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
./fs_functions.sh $dirPath 1
listing=$(find $dirPath -maxdepth $level)
for item in $listing
do
    ./fs_functions.sh $item 0
done
