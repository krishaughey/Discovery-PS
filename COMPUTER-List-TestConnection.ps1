## Ping/Test Connection on a list of Servers
##### Ping/Test Connection on a list of Servers
##### author: Kristopher F. Haughey
# $ErrorActionPreference = 'silentlycontinue'
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$ServerList = (Get-Content c:\Temp\ServerList.txt)
Write-Host "Enter the hostname or IP of your ping source (will accept 'localhost')" -ForegroundColor Green
$Source = Read-Host -Prompt "-->"

$Array = @()
foreach ($Server in $ServerList){
$colItems = Test-Connection -Source $Source -ComputerName $Server -Count 1 | Select-Object PSComputerName,Address,ProtocolAddress,ResponseTime,BufferSize,ReplySize
  foreach ($Reply in $colItems){
    $Array += New-Object PSObject -Property ([ordered]@{
      'Source' = $Source
      'Destination' = $Reply.Address
      'DestinationIP' = $Reply.ProtocolAddress
      'ResponseTime' = $Reply.ResponseTime
      'BytesSent' = $Reply.BufferSize
      'BytesRecived' = $Reply.ReplySize})
  }
}
$Array | Export-Csv "c:\Temp\PingStatus_$timestamp.csv" -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\PingStatus_$timestamp.csv"" -ForegroundColor Cyan
