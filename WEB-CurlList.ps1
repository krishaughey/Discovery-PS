## Curl List of Domains
##### TypeName: Microsoft.PowerShell.Commands.HtmlWebResponseObject
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$urls = get-content "c:\Temp\WebsiteList.txt"

foreach($url in $urls) {
    New-Object PSObject -Property @{
    url=$url;
    status=$(Invoke-WebRequest -URI $url).statuscode
    statusdescription=$(Invoke-WebRequest -URI $url).statusdescription

    } |
    export-csv "C:\WebsiteStatus_$timestamp.csv" -Append -NoTypeInformation
}
