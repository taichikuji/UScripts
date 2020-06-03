
# !/bin/bash

# Aceptar los dos numeros
echo "Escribe los dos numeros requeridos para realizar la operacion : "
read -p "1. Primer numero > " primer
read -p "2. Segundo numero > " segundo

# Que tipo de operacion se realiza
prompt="Escribe la opcion a utilizar : "
options=("Suma" "Resta" "Multiplicacion" "Division" "Salir")
PS3="$prompt"
select opt in "${options[@]}"
do
# Switch Case
# Calculadora
case $opt in
  Suma) 
  res=`expr $primer + $segundo`
  ;;
  Resta) 
  res=`expr $primer - $segundo`
  ;;
  Multiplicacion) 
  res=`expr $primer \* $segundo`
  ;;
  Division) 
  res=`expr $primer / $segundo`
  ;;
  Salir) 
  break
  ;;
  *) echo "ERROR"
esac
echo "Resultado : $res"
done