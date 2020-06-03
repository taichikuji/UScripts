# !/bin/bash

RED='\033[0;31m'
NC='\033[0m'
printf "${RED}$(ls)${NC}\n"
read -p "De la lista que acaba de aparecer, cual es el fichero que quieres comprobar? " fichero

if [ ! -f $fichero ];then
    printf "${RED}[ERROR 404] FICHERO NO EXISTE${NC}\n"
    exit 404
fi

if [ $(find $fichero -perm -g=r | wc -l) -eq 1 ]
then
    echo "Hay permisos de lectura"
    readp="r"
else
    echo "No hay acceso de lectura"
    readp="-"
fi

if [ $(find $fichero -perm -g=w | wc -l) -eq 1 ]
then
    echo "Hay permisos de escritura"
    writep="w"
else
    echo "No hay acceso de escritura"
    writep="-"
fi

if [ $(find $fichero -perm -g=x | wc -l) -eq 1 ]
then
    echo "Hay permisos de ejecución"
    exep="x"
else
    echo "No hay acceso de ejecución"
    exep="-"
fi

echo "Los permisos son los siguientes; $readp$writep$exep"
