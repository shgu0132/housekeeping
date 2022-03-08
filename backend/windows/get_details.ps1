# this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage: /bin/bash ./fs_functions.sh "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

 # this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage: /bin/bash ./fs_functions.sh "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

$dirPath=$Args[0]
$level=$Args[1]

echo "Capacity,Path,ItemType,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner"
.\fs_functions.ps1 $dirPath 1
$listing=(gci $dirPath -Depth $level).FullName
foreach ($item in $listing) {
    .\fs_functions.ps1 $item 0
}
