## Ping/Test Connection on a list of Servers
##### Ping/Test Connection on a list of Servers
##### author: Kristopher F. Haughey
# $ErrorActionPreference = 'silentlycontinue'
$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }
$ServerList = (Get-Content c:\Temp\ServerList.txt)
# Write-Host "Enter the hostname or IP of your ping source (will accept 'localhost')" -ForegroundColor Green
# $Source = Read-Host -Prompt "-->"

$Array = @()
foreach ($Server in $ServerList){
$colItems = Test-NetConnection -ComputerName $Server -Port 135 | Select-Object ComputerName,RemoteAddress,RemotePort,TcpTestSucceeded
  foreach ($Reply in $colItems){
    $Array += New-Object PSObject -Property ([ordered]@{
      'Destination' = $Reply.ComputerName
      'DestinationIP' = $Reply.RemoteAddress
      'RemotePort' = $Reply.RemotePort
      'TcpTestSucceeded' = $Reply.TcpTestSucceeded})
  }
}
$Array | Export-Csv "c:\Temp\Port_135_Status_$timestamp.csv" -NoTypeInformation
Write-Host "results have been exported to "c:\Temp\Port_135_Status_$timestamp.csv"" -ForegroundColor Cyan
