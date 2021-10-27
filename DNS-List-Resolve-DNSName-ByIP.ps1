## Resolve Internal DNS by IP
##### Resolve Internal DNS from a list of IP Addresses
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$AddressList = get-content c:\Temp\AddressList.txt
#$Server = Read-Host "Enter the Name or IP of the DNS Server"

$Array = @()
foreach ($IPAddress in $AddressList) {
    $Resolve = "" | Select-Object IPAddress,Name,Status,ErrorMessage
    try {
        $dnsRecord = Resolve-DnsName $IPAddress -ErrorAction Stop | Select-Object Server
        $Resolve.IPAddress = $IPAddress
        $Resolve.Name = ($dnsRecord.Server -join ',')
        $Resolve.Status = 'OK'
        $Resolve.ErrorMessage = ''
    }
    catch {
        $Resolve.IPAddress = $IPAddress
        $Resolve.Status = 'ERROR'
        $Resolve.ErrorMessage = $_.Exception.Message
    }
    $Array += $Resolve
}

$Array | export-csv c:\Temp\NSLookup_$Timestamp.csv -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\NSLookup_$Timestamp.csv"" -ForegroundColor Cyan
