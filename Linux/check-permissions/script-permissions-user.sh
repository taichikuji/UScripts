# !/bin/bash

fichero="$1"

[ $# -eq 0 ] && exit 1

if [ -r "$fichero" ]
then
    echo ""
    readp="r"
else
    echo "No hay acceso de lectura"
    readp="-"
fi

if [ -w "$fichero" ]
then
    echo ""
    writep="w"
else
    echo "No hay acceso de escritura"
    writep="-"
fi

if [ -x "$fichero" ]
then
    echo ""
    exep="x"
else
    echo "No hay acceso de ejecución"
    exep="-"
fi

echo "Los permisos son los siguientes; $readp$writep$exep"
