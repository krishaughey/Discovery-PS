## Curl List of Domains
##### TypeName: Microsoft.PowerShell.Commands.HtmlWebResponseObject
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
Write-Host "gathering domains from the txt file..."
$DomainList = get-content "c:\Temp\WebDomainList.txt"

Write-Host "running invoke-webrequest (curl) and selecting name and status... grab a coffee?" -ForegroundColor Green
$Array = @()
foreach ($Domain in $DomainList) {
    $Resolve = "" | Select-Object name,statusdescription,statuscode
    try {
        $Curl = Invoke-WebRequest $Domain
        $Resolve.Name = $Domain
        $Resolve.statusdescription = ($Curl.statusdescription -join ',')
        $Resolve.statuscode = ($Curl.statuscode -join ',')
  }
  #????????? MAYBE REMOVE THE TRY AND CATCH? GETTING 'OK' in statusdescription for all
    catch {
      $Resolve.Name = $Domain
      $Resolve.statusdescription = ($Curl.statusdescription -join ',')
      $Resolve.statuscode = ""
    }
    $Array += $Resolve
}
$Array | export-csv "C:\Temp\WebsiteStatus_$timestamp.csv" -NoTypeInformation
