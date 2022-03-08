Get-Content C:\temp\op.csv | select -first 1 | Set-Content -Path c:\temp\op1.csv
Get-Content C:\temp\op.csv | select -skip 1 > c:\temp\op2.csv
# Import-Csv c:\temp\op2.csv | Sort-Object @{e={$_.Size -as [int]}} | Export-Csv c:\temp\op3.csv -NoTypeInformation
# Get-Content C:\TEMP\op2.csv,C:\TEMP\op1.csv | Set-Content -Path C:\temp\op3.csv
Import-Csv C:\temp\op2.csv | Export-Csv c:\temp\op4.csv -NoTypeInformation
# Import-Csv C:\TEMP\op4.csv | ConvertTo-Html -Title "Usage Report" -PreContent "<H1>$($env:COMPUTERNAME)</H1>" -PostContent "<H5><i>$(get-date)</i></H5>" | Set-Content C:\TEMP\op.html
Copy-Item -Path .\format.css -Destination c:\temp\format.css -Force
Import-Csv C:\TEMP\op4.csv | ConvertTo-Html -Title "Usage Report" -PreContent "<H1>$(Get-Content C:\temp\op1.csv)</H1>" -PostContent "<H5><i>$(get-date)</i></H5>" -CssUri C:\temp\format.css | Set-Content C:\TEMP\op.html
## https://petri.com/convertto-html-tips-and-tricks