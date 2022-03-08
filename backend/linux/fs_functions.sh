#!/bin/bash

# this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# https://dextutor.com/difference-between-access-modification-and-change-time-in-linux/#:~:text=Modification%20Time%3A%20is%20the%20time,name%2C%20number%20of%20hard%20links.
# Modification Time: is the time when the contents of the file was last modified. For example, you used an editor to add new content or delete some existing content.
# Change Time: is the time when the file’s inode has been changed. For example, by changing permissions, ownership, file name, number of hard links.
# Usage: /bin/bash ./fs_functions.sh "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

dirPath=$1
isRoot=$2
capacity=`df -H $dirPath | grep / | awk '{print $2}'`
size=`du -s $dirPath 2>/dev/null | awk '{print $1}'`
if [[ -d $dirPath ]]; then
    nFiles=`find $dirPath -type f -print 2>/dev/null| wc -l`
    nDirectories=`find $dirPath -type d -print 2>/dev/null | wc -l`
elif [[ -f $dirPath ]]; then
    nFiles=1
    nDirectories=`find $dirPath -type d -print 2>/dev/null | wc -l`
else
    echo "$dirPath is not valid"
    exit 1
fi
if [ $isRoot -eq 1 ]
then
    percentParent="100"
else
    pSize=`du -s $dirPath/.. 2>/dev/null | awk '{print $1}'`
 #   echo $size,$pSize
    percentParent=$((100 * $size/$pSize ))
fi
fsOS=`uname`
if [ $fsOS != 'Linux' ]
then
    lastModified=`stat -f "%Sm" $dirPath`
    lastAccessed=`stat -f "%Sa" $dirPath`
    owner=`stat -f "%Su" $dirPath`
else
    lastModified=`stat --format="%y" $dirPath`
    lastAccessed=`stat --format="%x" $dirPath`
    owner=`stat --format="%U" $dirPath`
fi
echo Capacity,Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
echo $capacity,$dirPath,$size,$nFiles,$nDirectories,$percentParent,$lastModified,$lastAccessed,$owner
