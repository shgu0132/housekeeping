# this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage:.\fs_functions.ps1 "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

# $dirPath="\\EC2AMAZ-V9Q88DH\C$\Boot"
$dirPath=$Args[0]
$isRoot=$Args[1]

if ( (Test-Path -Path $dirPath -PathType Leaf) )    {
    $fileType="File"
    $nFiles=1
    $nDirectories=0
    $size=(Get-ChildItem $dirPath).Length
    if ( $isRoot -eq 1 )    {
        $percentParent="100"
    }
    else    {
        $pSize=(Get-ChildItem $dirPath/.. -Recurse | Measure-Object Length -Sum).Sum
        if ($pSize -like '')    {
            $pSize = 0
        }
        # echo $size,$pSize
        if ( $pSize -eq 0 ) {
            $percentParent = 100
        }
        else    {
            $percentParent=(100 * $size/$pSize)
        }
    }
}
elseif ( (Test-Path -Path $dirPath -PathType Container) )  {
    $fileType="Directory"
    $nFiles=(Get-ChildItem -Recurse -File -Path $dirPath | Measure-Object).Count
    $nDirectories=(Get-ChildItem -Recurse -Directory -Path $dirPath | Measure-Object).Count
    $size=(Get-ChildItem $dirPath -Recurse | Measure-Object Length -Sum).Sum
    if ($size -like '') {
        $size = 0
    }
    if ( $isRoot -eq 1 )    {
        $percentParent="100"
    }
    else    {
        $pSize=(Get-ChildItem $dirPath/.. -Recurse | Measure-Object Length -Sum).Sum
        if ($pSize -like '')    {
            $pSize = 0
        }
        # echo $size,$pSize
        $percentParent=(100 * $size/$pSize)
    }
}
else    {
    echo "$dirPath is not valid"
    exit 1
}
$lastModified=(Get-Item -Path $dirPath).LastWriteTime
$lastAccessed=(Get-Item -Path $dirPath).LastAccessTime 
$owner=(Get-ACL -Path $dirPath).Owner
echo "$dirPath,$fileType,$size/1MB,$nFiles,$nDirectories,$percentParent,$lastModified,$lastAccessed,$owner"
