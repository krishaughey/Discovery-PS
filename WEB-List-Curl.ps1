## Curl List of Domains
##### TypeName: Microsoft.PowerShell.Commands.HtmlWebResponseObject
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
Write-Host "gathering domains from the txt file..."
$DomainList = get-content "c:\Temp\WebDomainList.txt"
$ErrorActionPreference = 'silentlycontinue'
Write-Host "Running invoke-webrequest (curl) and selecting name, status, and 'RawContentLength' properties. Depending on the size of the domain list, this might take a while... grab a coffee?" -ForegroundColor Green
$Array = @()
foreach ($Domain in $DomainList){
$colItems = Invoke-WebRequest $Domain | Select-Object StatusDescription,StatusCode,RawContentLength
  foreach ($site in $colItems){
    $Array += New-Object PsObject -Property ([ordered]@{
      'DomainName' = $Domain
      'Status' = $site.StatusDescription
      'StatusCode' = $site.StatusCode
      'RawContentLength' = $site.RawContentLength})
  }
}
$Array | export-csv "C:\Temp\WebsiteStatus_$timestamp.csv" -NoTypeInformation
