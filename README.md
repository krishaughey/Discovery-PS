## SystemDiscovery-PS/Nmap
##### PowerShell and Nmap statements/scripts for discovering hosts, DNS, ports, certificates, etc...

##### Simple Timestamp Variable
> $timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }

> https://www.stationx.net/nmap-cheat-sheet/

###### Nmap - Scan a Subnet for Responses
    nmap -sn 10.10.16.0/24

###### Nmap - Scan a Host for Ports (disable host scan, port only)
    nmap -Pn 10.101.16.235

###### Nmap - Deterimine Cyphers Used on Server/Webpage
    nmap --script ssl-enum-ciphers -p 443 example.com

###### Nmap - Determine Cert info
    nmap ssl-cert -sV -sC 10.101.16.235

###### Nmap - Determine Cert Cipher Info on specific port
    nmap -sV --script ssl-enum-ciphers -p 443 <host>

###### Nmap - Retrieve Public Cert on Port
    nmap -sV -sC -vv -p 636 10.101.16.13

###### Nmap - Scan from a list of Nodes
    nmap -iL list-of-ips.txt

###### PS - Ping from a specified source
    Test-Connection -Source <HostName1> -Destination <HostName2>
