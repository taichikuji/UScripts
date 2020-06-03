#!/bin/bash
ROOT_UID=0
E_NOTROOT=87

if [ "$UID" -ne "$ROOT_UID" ]; then
        echo "error, necesitas root para ejecutar."
        exit $E_NOTROOT
fi

echo "Mi ip privada es: $(hostname -I) y mi ip publica es: $(curl --silent ifconfig.me)"

echo "Mi DNS configurada con este dispositivo es $(cat /etc/resolv.conf | grep -oP 'nameserver \K\S+' | tr '\n' ' ')"

gateway=`ip route show 0.0.0.0/0 | grep -oP 'via \K\S+'`
echo "Mi Gateway es: $gateway"

ping -c 3 $gateway > /dev/null

if [ $? = 0 ]; then
	echo "Conexión con el gateway funciona!"
else
	echo "Conexión con el gateway no funciona!"
fi

read -p "Cual es la ip que quieres buscar? " ip

ping -c 3 $ip > /dev/null

if [ $? = 0 ]; then
	echo "Conexión con $ip funciona!"
else
	echo "Conexión con $ip no funciona!"
fi