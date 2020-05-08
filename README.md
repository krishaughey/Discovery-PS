# SystemDiscovery-PS
### PowerShell statements and scripts for discovering hosts, DNS, ports, certificates, etc...

> https://www.stationx.net/nmap-cheat-sheet/

###### Scan a Subnet for Responses
    nmap -sn 10.10.16.0/24

###### Scan a Host for Ports (disable host scan, port only)
    nmap -Pn 10.101.16.235

###### Deterimine Cyphers Used on Server/Webpage
    nmap --script ssl-enum-ciphers -p 443 example.com

###### Determine Cert info
    nmap ssl-cert -sV -sC 10.101.16.235

###### Determine Cert Cipher Info on specific port
    nmap -sV --script ssl-enum-ciphers -p 443 <host>

###### Retrieve Public Cert on Port
    nmap -sV -sC -vv -p 636 10.101.16.13

###### Scan from a list of Nodes
    nmap -iL list-of-ips.txt
