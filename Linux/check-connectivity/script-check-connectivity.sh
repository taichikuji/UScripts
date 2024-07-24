#!/bin/bash
ROOT_UID=0
E_NOTROOT=87

if [ "$UID" -ne "$ROOT_UID" ]; then
        echo "Error, you need root to execute."
        exit $E_NOTROOT
fi

echo "My private IP is: $(hostname -I) and my public IP is: $(curl --silent ifconfig.me)"

echo "The DNS configured for this device is $(grep -oP 'nameserver \K\S+' /etc/resolv.conf | tr '\n' ' ')"

gateway=$(ip route show 0.0.0.0/0 | grep -oP 'via \K\S+')
echo "My Gateway is: $gateway"

ping -c 3 $gateway > /dev/null

if [ $? -eq 0 ]; then
        echo "Connection to the gateway works!"
else
        echo "Connection to the gateway does not work!"
fi

read -p "What is the IP you want to search? " ip

ping -c 3 $ip > /dev/null

if [ $? -eq 0 ]; then
        echo "Connection to $ip works!"
else
        echo "Connection to $ip does not work!"
fi