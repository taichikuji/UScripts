#!/bin/bash

# Removing microsoft folder from /opt
rm -fr /opt/microsoft

# Removing pwsh link
rm -fr /usr/bin/pwsh

# Removing apt package just in case
echo $(apt purge powershell -y)

# Removing packages-microsoft-prod package
echo $(dpkg --purge packages-microsoft-prod)

echo "Everything is purged now!"