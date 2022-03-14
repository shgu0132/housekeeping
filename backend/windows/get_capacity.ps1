$dirPath=$Args[0]
$pathType=$dirPath.substring(0, 2)
if ($pathType -like '\\')   {
    $driveletters=@("D","E","F","G","H","I","J","K","L","N","O","P","Q","R","S","T","U","V","W")
    $nwobj=New-Object -comobject WScript.Network
    ForEach($driveLetter in $driveletters){
        if (Get-PSDrive $driveLetter -ErrorAction SilentlyContinue) {
            Continue
        } else {
            # $status=New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $dirPath
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
    # $status=Remove-PSDrive $driveLetter 
}
elseif ($pathType -like '?:')   {
    $driveLetter = $pathType.substring(0,1)
    $drive=Get-PSdrive $driveLetter
    $free=($drive.free)
    $used=($drive.used)
    $total=($free+$used)
    $totalMB=[math]::Round($total/1MB)    
}
echo "Capacity (MB),$totalMB"
