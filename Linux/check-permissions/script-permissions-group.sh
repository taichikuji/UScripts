#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
printf "${RED}$(ls)${NC}\n"

read -p "From the list that just appeared, which file do you want to check? " file

if [ ! -f "$file" ]; then
    printf "${RED}[ERROR 404] FILE NOT FOUND${NC}\n"
    exit 404
fi

if find "$file" -perm -g=r -print -quit | grep -q .; then
    echo "Read access is available"
    readp="r"
else
    echo "No read access"
    readp="-"
fi

if find "$file" -perm -g=w -print -quit | grep -q .; then
    echo "Write access is available"
    writep="w"
else
    echo "No write access"
    writep="-"
fi

if find "$file" -perm -g=x -print -quit | grep -q .; then
    echo "Execute access is available"
    exep="x"
else
    echo "No execute access"
    exep="-"
fi

echo "The permissions are as follows: $readp$writep$exep"
