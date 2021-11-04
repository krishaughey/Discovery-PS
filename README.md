## SystemDiscovery-PS/Nmap
##### PowerShell and Nmap statements/scripts for discovering hosts, DNS, ports, certificates, etc...

##### Simple Timestamp Variable
> $timestamp = Get-Date -Format s | ForEach-Object { $_ -replace ":", "." }

###### Get next hop (no internal)
  > Get-NetRoute | Where-Object -FilterScript { $_.NextHop -Ne "::" } | Where-Object -FilterScript {  $_.NextHop -Ne "0.0.0.0" } | Where-Object -FilterScript { ($_.NextHop.SubString(0,6) -Ne "fe80::") }

### Nmap statements
> https://www.stationx.net/nmap-cheat-sheet/

###### Nmap - Scan a Subnet for Responses
    nmap -sn 10.10.16.0/24

###### Nmap - Scan a Host for Ports (disable host scan, port only)
    nmap -Pn 10.101.16.235

###### Nmap - Deterimine Cyphers Used on Server/Webpage
    nmap --script ssl-enum-ciphers -p 443 example.com

###### Nmap - Determine Cert info
    nmap --script ssl-cert -sV -sC vpn.DOMAIN.COM

###### Nmap - Determine Cert Cipher Info on specific port
    nmap -sV --script ssl-enum-ciphers -p 443 <host>

###### Nmap - Retrieve Public Cert on Port
    nmap -sV -sC -vv -p 636 10.101.16.13

###### Nmap - Scan from a list of Nodes
    nmap -iL list-of-ips.txt

###### Nmap - Scan over VPN Connection
    nmap -v -e ppp0 -n -T4 -Pn --unprivileged <HOST or IP>

###### PS - Ping from a specified source
    Test-Connection -Source <HostName1> -Destination <HostName2>
