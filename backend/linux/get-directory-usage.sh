#!/bin/bash
# enter path as parameter
cd $1
ls $1 | xargs du -sh 2>/dev/null | awk '{print $1}'