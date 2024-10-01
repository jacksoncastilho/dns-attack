#!/bin/bash

echo -e "\n"
echo "+-+-+-+-+-+-+-+-+-+"
echo "|d|n|s|a|t|t|a|c|k|"
echo "+-+-+-+-+-+-+-+-+-+"
echo -e "\n"

# Function to perform a DNS zone transfer attack
_dnsZoneTransfer() {
    # Prompts the user for the domain
    read -p "domain: " domain

    # Iterates over each name server (NS) of the domain
    for ns in $(host -t ns $domain | cut -d " " -f 4); do
        echo -e "\n######## $ns ########\n"
        
        # Attempts to perform a zone transfer for the domain on the current NS server
        host -t AXFR $domain $ns
    done

    # Exits the function with a success code
    exit 0
}

# Function to perform a brute force attack on subdomains
_dnsBrute() {
    # Prompts the user for the domain
    read -p "domain: " domain

    # Checks if the subdomains.txt file exists and uses its contents as a wordlist
    for word in $([[ -f subdomains.txt ]] && cat subdomains.txt); do
        # Attempts to resolve the subdomain and ignores results with "NXDOMAIN"
        host $word.$domain | grep -v NXDOMAIN
    done

    # Exits the function with a success code
    exit 0
}

# Function to perform a DNS reverse lookup
_dnsReverse() {
    # Prompts the user for the target IP address
    read -p "target ip: " target
    
    # Displays the IP range related to the provided IP using the whois query
    whois $target | grep "inetnum" 
    
    # Extracts the subnet prefix from the provided IP
    subnet_prefix=$(echo $target | cut -d . -f 1,2,3)
    echo -e "subnet prefix: " $subnet_prefix 
    
    # Prompts the user for the range limits of the IPs to be checked
    read -p "range first: " first
    read -p "range last: " last
    
    echo -e "\n"
    
    # Iterates over the range of IP addresses and performs a PTR lookup for each one
    for host_id in $(seq $first $last); do
        host -t ptr $subnet_prefix.$host_id
    done

    # Exits the function with a success code
    exit 0
}

# Displays choices for the type of attack
echo Choice an attack:
select choice in dnszonetransfer dnsbrute dnsreverse; do
    case $choice in
        # If the user selects dnszonetransfer, call the corresponding function
        dnszonetransfer ) _dnsZoneTransfer ;;
        # If the user selects dnsbrute, call the corresponding function
        dnsbrute        ) _dnsBrute ;;
        # If the user selects dnsreverse, call the corresponding function
        dnsreverse      ) _dnsReverse ;;
        # Any other choice exits the script
        *               ) exit 0 ;;
    esac
done
