## Resolve External DNS
##### Resolve External DNS from list of domain names using Google and Open DnsName
##### author: Kristopher F. Haughey

$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }

## if you have a short list, replace line 8 with <$DomainNames = @('google.com','bing.com','duckduckgo.com')>
$DomainNames = get-content c:\Temp\WebsiteList.txt
$ServerList = @('8.8.8.8','8.8.4.4','208.67.222.222','208.67.220.220')

$Array = @()
foreach ($Name in $DomainNames) {
    $Resolve = "" | Select-Object Name,IPAddress,Status,ErrorMessage
    try {
        $dnsRecord = Resolve-DnsName $Name -Server $ServerList -ErrorAction Stop | Where-Object {$_.Type -eq 'A'}
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
$Array | export-csv c:\Temp\ExternalDNS_$Timestamp.csv -NoTypeInformation
