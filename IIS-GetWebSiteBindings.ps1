# IIS-GetWebSitesBindigs.ps1
## Get all website bindings from WebsiteList and report to CSV
##### Requires the webadministration module
##### > https://docs.microsoft.com/en-us/powershell/module/webadministration/?view=win10-ps

$timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }

get-website | select name,id,state,physicalpath,
@{n="Bindings"; e= { ($_.bindings | select -expa collection) -join ';' }} ,
@{n="LogFile";e={ $_.logfile | select -expa directory}},
@{n="attributes"; e={($_.attributes | % { $_.name + "=" + $_.value }) -join ';' }} |


Export-Csv -Path C:\Temp\WebsiteBindings_$timestamp.csv -NoTypeInformation
