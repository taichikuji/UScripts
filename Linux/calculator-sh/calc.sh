
# !/bin/bash

# Aceptar los dos numeros
echo "Escribe los dos numeros requeridos para realizar la operacion : "
read -p "1. Primer numero > " primer
read -p "2. Segundo numero > " segundo

# Que tipo de operacion se realiza
echo "Escribe la opcion a utilizar :"
echo "1. Suma"
echo "2. Resta"
echo "3. Multiplicacion"
echo "4. Division"
read op

# Switch Case
# Calculadora
case $op in
  1)res=`expr $primer + $segundo`
  ;;
  2)res=`expr $primer - $segundo`
  ;;
  3)res=`expr $primer \* $segundo`
  ;;
  4)res=`expr $primer / $segundo`
  ;;
esac
echo "Resultado : $res"
