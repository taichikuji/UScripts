#!/bin/bash
# Folder to save the backup file
BK="/mnt/sdb1"
# Folder to backup
OG="/home/user"

# Create the $OG folder if it doesn't exist
if [ ! -d $OG ]; then
    mkdir $OG

# If files exist inside $OG, continue
elif [ "$(ls -A $OG)" ]; then
    [ ! -d $BK ] && mkdir $BK
    # Check / generate $BK, and save the backup's filename onto $BKTAR
    BKTAR="$BK/BACKUP_$(date +%d-%m-%y_%H-%M-%S).tar.xz"

    # Create backup file
    tar cfvJ $BKTAR $OG

    # Remove 7+ days old backup files
    find $BK/* -mtime +7 -delete
fi