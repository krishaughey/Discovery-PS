## Resolve DNS from List of Servers
##### Resolve External DNS from list of domain names using Google and Open DnsName
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$AddressList = Get-Content c:\Temp\AddressList.txt
$ServerList = Read-Host "Enter the DNS server to wish to use (e.g. - DC01.domain.local)"

$Array = @()
foreach ($Name in $AddressList) {
    $Resolve = "" | Select-Object Name,IPAddress,Status,ErrorMessage
    try {
        $dnsRecord = Resolve-DnsName $Name -Server $ServerList -ErrorAction Stop #| Where-Object {$_.Type -eq 'A'}
        $Resolve.Name = $Name
        $Resolve.IPAddress = ($dnsRecord.IPAddress -join ',')
        $Resolve.Status = 'OK'
        $Resolve.ErrorMessage = ''
    }
    catch {
        $Resolve.Name = $Name
        $Resolve.IPAddress = ''
        $Resolve.Status = 'ERROR'
        $Resolve.ErrorMessage = $_.Exception.Message
    }
    $Array += $Resolve
}
$Array | export-csv c:\Temp\DNSLookup_$timestamp.csv -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\DNSLookup_$timestamp.csv"" -ForegroundColor Cyan
