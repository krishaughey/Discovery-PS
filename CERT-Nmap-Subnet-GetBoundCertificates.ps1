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
