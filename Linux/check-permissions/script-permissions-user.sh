# !/bin/bash

file="$1"

[ $# -eq 0 ] && exit 1

if [ -r "$file" ]
then
    echo ""
    readp="r"
else
    echo "No read access"
    readp="-"
fi

if [ -w "$file" ]
then
    echo ""
    writep="w"
else
    echo "No write access"
    writep="-"
fi

if [ -x "$file" ]
then
    echo ""
    exep="x"
else
    echo "No execute access"
    exep="-"
fi

echo "Permissions are as follows: $readp$writep$exep"