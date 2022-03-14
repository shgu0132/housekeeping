# this script generates below details about the path passed as a parameter
# Path,ItemType,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage: ./get_details.ps1 "path" [N]
# N indicates depth-level which must be a positive integer

$dirPath=$Args[0]
$level=$Args[1]

.\get_capacity.ps1 $dirPath
echo "Path,ItemType,Size (MB),No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner"
.\fs_functions.ps1 $dirPath 1
$listing=(gci $dirPath -Depth $level).FullName
foreach ($item in $listing) {
    .\fs_functions.ps1 $item 0
}
