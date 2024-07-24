#!/bin/bash
ROOT_UID=0
E_NOTROOT=87

if [[ "$UID" -ne "$ROOT_UID" ]]; then
        echo "Error: You need root to execute."
        exit "$E_NOTROOT"
fi

read -rp "What is the user you want to search for? " user

if getent passwd "$user" > /dev/null 2>&1; then
        echo "The user $user already exists, showing user information..."
        echo "Printing the user by the id command" && id "$user"
        echo "Printing the groups by the groups command" && groups "$user"
        echo "Printing by grepping /etc/passwd" && grep -i "$user" /etc/passwd
else
        read -rp "It does not exist, do you want to create the user $user? (y/n) " response
        if [[ "$response" =~ ^[Yy]$ ]]; then
                echo "Creating user..."
                adduser "$user"
                su "$user" && echo "Done!"
        else
                echo "Cancelling user creation..."
        fi
fi

exit 0