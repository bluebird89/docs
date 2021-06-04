# Nmap  Network Mapper

* an open-source security tool for network exploration, security scanning, and auditing. It was designed to rapidly scan large networks, although it works fine against single hosts. 
* Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. 
* While Nmap is commonly used for security audits, many systems and network administrators find it useful for routine tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime.
* what is it used for
    - Find running computers on the local network
    - What IP addresses did you find running on the local network?
    - Discover the operating system of your target machine
    - Find out what ports are open on the machine that you just scanned?
    - See if the system is infected with malware or virus.
    - Search for unauthorized servers or network service on your network.
    - Locate and remove computers which don’t meet the organization’s minimum level of security.


```sh
sudo apt-get install nmap
namp -V|--wersion
```

* the definitive port scanner,kicking off in two distinct phases
  - the discovery phase
  - the scan phase
    + `nmap -P0 network` Don’t worry about discovery — just scan.
    + `nmap -PS21,22,23,80 network` discovery using TCP SYNs on ports that you specify
* the default scan type is TCP SYN (-sS)
* -p By default, nmap scans 1663 ports (in version 3.81), but it’s possible and often prudent to change how many and/or which ports are scanned
* -sU  scan using the UDP protocol
* TCP scans
  - `nmap -sF host` the FIN scan
  - `nmap -sA host` the ACK scan
  - `nmap -sX host` the XMAS scan:sends a TCP packet with the FIN, URG, and PSH flags
  - `nmap -sN host` the NULL scan
* `nmap -sP network` Ping Scan:this sends both an ICMP echo and a TCP ACK to the hosts in the target range
* `nmap -p1-10000 -sV host` Version Scanning attain version information for various TCP and UDP services on target machines.
* `nmap -O network` attempt to determine what operating system a target host is running
* `nmap –resume logfile_name` Resume An Interrupted Scan
  - requires that you have a logfile in either the human readable or grepable format, so it’s yet another reason to go ahead and use the -oA option when performing all scans
* Output `nmap -oA output_file network`
  - create three files in the current directory — output_file.nmap (human readable), output_file.gnmap (grepable), and output_file.xml (XML)
  - also produce these seperately via -oN, -oG, and -oX respectively.
* Scan Speed
  - offers options to throttle the speed of your scans by running its probes serially rather than in parallel and by varying the time between each probe.
  - has several parameters — Paranoid, Sneaky, Polite, Normal, Aggressive, and Insane.
  - The difference between them is in how long they delay between each packet they send. Paranoid waits 5 minutes, Sneaky waits 15 seconds, and Polite waits at least .4 seconds.

```sh
# Scan a single host or an IP
nmap server1.cyberciti.biz 
## Scan a host name with more info###
nmap -v server1.cyberciti.biz

nmap 192.168.1.2
nmap 192.168.1.1 192.168.1.2 192.168.1.3

nmap 192.168.10.0/24
## works with same subnet i.e. 192.168.1.0/24 
nmap 192.168.1.1,2,3
nmap 192.168.1.2-10
nmap 192.168.1.*

# Read list of hosts/networks from a file，Append names as follows:
server1.cyberciti.biz
192.168.1.0/24
192.168.1.1/24
10.1.2.3
localhost

nmap -iL /tmp/test.txt

# Excluding hosts/networks (IPv4) from nmap scan examples
nmap 192.168.1.0/24 --exclude 192.168.1.5
nmap 192.168.1.0/24 --exclude 192.168.1.5,192.168.1.254
nmap -iL /tmp/scanlist.txt --excludefile /tmp/exclude.txt
```

```
## Ping only scan ##
nmap -sP 192.168.1.2
 
## Scan and do traceroute ##
nmap --traceroute IP-ADDRESS
nmap --traceroute DOMAIN-NAME-HERE
 
## TCP SYN Scan ##
nmap -sS 192.168.1.2
 
## UDP Scan ##
nmap -sU 192.168.1.2
 
## IP protocol scan ##
nmap -sO 192.168.1.2
 
## Scan port 80, 25, 443 ##
nmap -p 80 192.168.1.2
nmap -p http 192.168.1.2
nmap -p 25 192.168.1.2
nmap -p smtp 192.168.1.2
nmap -p 443 192.168.1.2
nmap -p 80,24,443 192.168.1.2
 
## Scan port ranges ##
nmap -p 512-1024 192.168.1.2
 
## Scan for OS i.e. Operating System Detection ##
nmap -O 192.168.1.2
nmap -O --osscan-guess 192.168.1.2
 
## Scan for application server version ##
nmap -sV 192.168.1.2
nmap -p1-10000 192.168.10.0/24
nmap -p22,23,10000-15000 192.168.10.0/24

# UDP scan (-sU) and then defining which ports on each protocol to scan
# TCP 21,22,23 UDP 53,137
nmap -sU -pT:21,22,23,U:53,137 192.168.10.0/24

# scan using the UDP protocol.
nmap -sU host
```
