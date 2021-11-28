# Folder to save the backup file
$BK="C:\Backup"
# Folder to backup
$OG="C:\Users"

# Create the $OG folder if it doesn't exist
If ( -not $(Test-Path -Path $OG)) {
    New-Item -Path $OG

# If files exist inside $OG, continue
} ElseIf (Get-ChildItem $OG -name -recurse *) {
    If ( -not $(Test-Path -Path $BK)) { New-Item -Path $BK }

    # Check / generate $BK, and save the backup's filename onto $BKZIP
    $BKZIP="$BK/BACKUP_$(Get-Date -Format "hh-mm_dd-MM-yyyy").zip"

    # Create backup file
    Compress-Archive -Path $OG -DestinationPath $BKZIP

    # Remove 7+ days old backup files
    Get-ChildItem -Path $BK -Recurse | Where-Object { $_.LastWriteTime –lt (Get-Date).AddDays(-7) } | Remove-Item -Recurse
}