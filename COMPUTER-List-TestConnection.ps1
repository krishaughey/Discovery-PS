## Ping a list of Servers
##### Ping/ICMP Test-Connection on a list of Servers
##### Test-Connection version 7.0.0.0
##### author: Kristopher F. Haughey
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$ServerList = (Get-Content c:\Temp\ServerList.txt)

$Array = @()
foreach ($Server in $ServerList){
$colItems = Test-Connection -ComputerName $Server -Count 1 | Select-Object Source,Destination,Address,Status,Latency
  foreach ($Reply in $colItems){
    $Array += New-Object PSObject -Property ([ordered]@{
      'Source' = $Reply.Source
      'Destination' = $Reply.Destination
      'DestinationIP' = $Reply.Address
      'Status' = $Reply.Status
      'ResponseTime' = $Reply.Latency})
  }
}
$Array | Export-Csv "c:\Temp\ICMP_Test_$timestamp.csv" -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\ICMP_Test_$timestamp.csv"" -ForegroundColor Cyan
