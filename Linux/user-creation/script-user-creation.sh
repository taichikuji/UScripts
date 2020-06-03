#!/bin/bash
ROOT_UID=0
E_NOTROOT=87

if [ "$UID" -ne "$ROOT_UID" ]; then
        echo "error, necesitas root para ejecutar."
        exit $E_NOTROOT
fi

read -p "Cual es el usuario que quieres buscar? " user
if getent passwd $user > /dev/null 2>&1; then
        echo "El usuario $user ya existe, mostrando informacion del usuario..."
        echo "Printando el usuario mediante el comando id" && id $user
        echo "Printando los grupos mediante el comando groups" && groups $user
        echo "Printando mediante grep a /etc/passwd" && grep -i $user /etc/passwd
else
                read -p "No existe, quieres crear el usuario $user? (y/n) " respuesta
                if [ "$respuesta" = "y" ]; then
                        echo "Creando usuario..."
                        adduser $user
                        su $user && echo "Hecho!"
                else
                        echo "Cancelando creacion de usuario..."
                fi
fi
exit 0