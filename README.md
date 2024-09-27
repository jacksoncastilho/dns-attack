# DNS Attack Script

This is a Bash script that performs different types of DNS attacks: DNS Zone Transfer, Subdomain Brute Force, and Reverse DNS lookup. The script is interactive and allows the user to choose which attack method to execute.

## Requirements

- The script uses Unix commands like `host` and `whois`. Make sure these commands are installed on your system.
- A file named `subdomains.txt` with a list of subdomains is required for the DNS Brute Force function.

## Usage

### 1. Running the script

```bash
chmod +x dnsattack.sh
./dnsattack.sh
```

### 2. Choosing an attack

When you run the script, you will be prompted to choose between the following attack options:

- `dnszonetransfer`: Attempts to perform a DNS zone transfer on the specified domain.
- `dnsbrute`: Performs brute force of subdomains using a list (`subdomains.txt`).
- `dnsreverse`: Performs a reverse lookup on a range of IPs.

## Detailed Functions

### 1. DNS Zone Transfer (`dnszonetransfer`)

The script will attempt to perform a DNS zone transfer on the specified domain. This attack queries the domain's authoritative name servers for DNS records.

Execution example:

```
domain: example.com
######## ns1.example.com ########
[zone transfer result]
```

### 2. Subdomain Brute Force (`dnsbrute`)

The script uses a list of subdomains (`subdomains.txt`) and attempts to resolve each subdomain to find valid records.

Execution example:

```
domain: example.com
subdomain1.example.com has address 192.168.1.1
subdomain2.example.com has address 192.168.1.2
```

### 3. Reverse DNS Lookup (`dnsreverse`)

This method performs a reverse lookup on a range of IPs specified by the user. It attempts to find PTR records for the given IP range.

Execution example:

```
target ip: 192.168.1.1
inetnum: 192.168.1.0 - 192.168.1.255
subnet prefix: 192.168.1
range first: 1
range last: 5

1.168.192.in-addr.arpa domain name pointer host1.example.com.
2.168.192.in-addr.arpa domain name pointer host2.example.com.
```

## Notes

- Use this script only for educational purposes or testing in controlled environments and on domains you own or have permission to test.
- Misuse of this script can be considered illegal in many countries.

## License

This project is licensed under the [MIT License](LICENSE).
