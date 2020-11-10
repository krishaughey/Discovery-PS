## Discover Certificates on Subnet
##### Nmap SSL-Cert -- scan a selected subnet for certitficates in use and report
##### author: Kristopher F. Haughey

$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$TempDir = "c:\Temp\"
$TempFile = "ScanSubnet_Temp.xml"
Write-Host "enter a hostname, IP, or IP range (CIDR)" -ForegroundColor Green
$Target = Read-Host -Prompt "-->"

$Array = @()
foreach ($Server in $ServerList){
$colItems = nmap --script ssl-cert -sV -sC -oX $TempDir+$TempFile $Target
[xml]$XmlDocument = Get-Content -Path $TempDir$TempFile

  foreach ($Reply in $colItems){
    $Array += New-Object PSObject -Property ([ordered]@{
      'Scope' = $Target
      'Destination' = $Reply.Address
      'DestinationIP' = $Reply.ProtocolAddress
      'ResponseTime' = $Reply.ResponseTime
      'BytesSent' = $Reply.BufferSize
      'BytesRecived' = $Reply.ReplySize})
  }
}
$Array | Export-Csv "c:\Temp\PingStatus_$timestamp.csv" -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\CertificateBindings-Report_$timestamp.csv"" -ForegroundColor Cyan
