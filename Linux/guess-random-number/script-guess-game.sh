#!/bin/bash

number=$(($RANDOM % 20 + 1))
count=0

read -p "Que numero crees que es? (es un numero del 1 al 20) : " op

while [[ "$count" -lt "7" ]]; do
	if [[ $op -gt $number ]]; then
		echo "El numero es demasiado alto! Prueba otra vez."
	else
		echo "El numero es demasiado bajo! Prueba otra vez."
	fi
	read -p "Tienes otro intento! Que numero crees que es? " op
	let count=count+1

	if [[ $op -eq $number ]]; then
		break
	fi
done
	if [[ "$count" -eq "7" ]]; then
		echo "Has fallado..."
		exit 0
	else
		echo "Lo has adivinado! En $count intentos!"
		exit 0
	fi
