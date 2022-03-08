# this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage: /bin/bash ./fs_functions.sh "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

 # this script generates below details about the path passed as a parameter
# Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner
# Usage: /bin/bash ./fs_functions.sh "path" 0|1
# 0 indicates that path is non-root directory and 1 indicates that path is a root directory

# $dirPath="\\EC2AMAZ-V9Q88DH\C$\Boot"
$dirPath=$Args[0]
$isRoot=$Args[1]
$driveletters=@("D","E","F","G","H","I","J","K","L","N","O","P","Q","R","S","T","U","V","W")
$nwobj=New-Object -comobject WScript.Network
ForEach($driveLetter in $driveletters){
	if (Get-PSDrive $driveLetter -ErrorAction SilentlyContinue) {
    	Continue
	} else {
    	$status=New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $dirPath
        $qualifier = $driveletter + ":"
		$status=$nwobj.mapnetworkdrive($qualifier,$dirPath)
        Break
	}
}
# echo $driveLetter,$drive
$drive=Get-PSdrive $driveLetter
$free=($drive.free)
$used=($drive.used)
$total=($free+$used)
# $freeinPercentage=($free/$total*100)
# $freewithoutdecimal=([math]::Round($freeinPercentage))
# $totalGB=[math]::Round($total/1gb)
# Write-Output "Share $dirPath has total space of $total bytes, free=$free bytes, used=$used bytes"
$status=$nwobj.removenetworkdrive($qualifier)
$status=Remove-PSDrive $driveLetter 

if ( (Test-Path -Path $dirPath -PathType Leaf) )    {
    $nFiles=1
    $nDirectories=0
}
elseif ( (Test-Path -Path $dirPath -PathType Container) )  {
    $nFiles=(Get-ChildItem -Recurse -File -Path $dirPath | Measure-Object).Count
    $nDirectories=(Get-ChildItem -Recurse -Directory -Path $dirPath | Measure-Object).Count
}
else    {
    echo "$dirPath is not valid"
    exit 1
}
$size=(Get-ChildItem $dirPath -Recurse | Measure-Object Length -Sum).Sum
if ( $isRoot -eq 1 )    {
    $percentParent="100%"
}
else    {
    $pSize=(Get-ChildItem $dirPath/.. -Recurse | Measure-Object Length -Sum).Sum
    echo $size,$pSize
    $percentParent=(100 * $size/$pSize )
}
$lastModified=(Get-Item -Path $dirPath).LastWriteTime
$lastAccessed=(Get-Item -Path $dirPath).LastAccessTime 
$owner=(Get-ACL -Path $dirPath).Owner
echo "Capacity,Path,Size,No Of Files,No of Directories,percent of Parent,Last Modified,Last Accessed,Owner"
echo "$total,$dirPath,$size,$nFiles,$nDirectories,$percentParent,$lastModified,$lastAccessed,$owner"
 
