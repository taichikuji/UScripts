#!/bin/bash

# Removing Microsoft folder from /opt
if [ -d /opt/microsoft ]; then
    rm -rf /opt/microsoft
fi

# Removing pwsh link
if [ -L /usr/bin/pwsh ]; then
    rm -f /usr/bin/pwsh
fi

# Removing apt package just in case
apt purge -y powershell

# Removing packages-microsoft-prod package
dpkg --purge packages-microsoft-prod

echo "Everything is purged now!"