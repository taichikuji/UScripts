# !/bin/bash
#for loop
for i do
    sum=$(expr $sum + $i)
done
echo "La suma de los numeros introducidos es : $sum"
