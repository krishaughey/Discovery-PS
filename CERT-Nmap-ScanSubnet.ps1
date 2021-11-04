## Discover Certificates on Subnet
##### Nmap SSL-Cert -- scan a selected subnet for bound certitficates and report in all three nmap formats
##### author: Kristopher F. Haughey

$TempDir = "c:\Temp\CertScans\"
$TempFile = "CertScan"
$TargetList = Import-csv "c:\Temp\CertScans\TargetList.csv"
foreach ($Target in $TargetList){
	$subnet = $target.subnet
	$nickName = $target.nickName
    	Invoke-Command -ScriptBlock {nmap $subnet --script ssl-cert -sV -sC -oA $TempDir$nickName$TempFile}
}
#### sample CSV
'@subnet,nickName
192.168.251.0/24,251
192.168.200.0/24,200
192.168.103.0/24,103
192.168.194.0/24,194
@'
