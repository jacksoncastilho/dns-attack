#!/bin/bash

echo -e "\n"
echo "+-+-+-+-+-+-+-+-+-+"
echo "|d|n|s|a|t|t|a|c|k|"
echo "+-+-+-+-+-+-+-+-+-+"
echo -e "\n"

_dnsZoneTransfer() {
    read -p "domain: " domain

    for ns in $(host -t ns $domain | cut -d " " -f 4); do
        echo -e "\n######## $ns ########\n"
        host -t AXFR $domain $ns
    done

    exit 0
}

_dnsBrute() {
    read -p "domain: " domain

    for word in $([[ -f subdomains.txt ]] && cat subdomains.txt); do
        host $word.$domain | grep -v NXDOMAIN
    done

    exit 0
}

_dnsReverse() {
    read -p "target ip: " target
    
    whois $target | grep "inetnum" 
    
    subnet_prefix=$(echo $target | cut -d . -f 1,2,3)
    echo -e "subnet prefix: " $subnet_prefix 
    
    read -p "range first: " first
    read -p "range last: " last
    
    echo -e "\n"
    
    for host_id in $(seq $first $last); do
        host -t ptr $subnet_prefix.$host_id
    done

    exit 0
}

echo Choice an attack:
select choice in dnszonetransfer dnsbrute dnsreverse; do
    case $choice in
        dnszonetransfer ) _dnsZoneTransfer ;;
        dnsbrute        ) _dnsBrute ;;
        dnsreverse      ) _dnsReverse ;;
        *               ) exit 0 ;;
    esac
done
