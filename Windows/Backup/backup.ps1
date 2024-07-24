$BackupFolder = "C:\Backup"
$OriginalFolder = "C:\Users"

if (-not (Test-Path -Path $OriginalFolder)) {
    New-Item -Path $OriginalFolder -ItemType Directory
} elseif (Get-ChildItem -Path $OriginalFolder -Recurse) {
    if (-not (Test-Path -Path $BackupFolder)) {
        New-Item -Path $BackupFolder -ItemType Directory
    }

    $BackupFileName = "$BackupFolder\BACKUP_$(Get-Date -Format 'HH-mm_dd-MM-yyyy').zip"
    Write-Host "Name of the file will be $BackupFileName !"

    Compress-Archive -Path $OriginalFolder -DestinationPath $BackupFileName -CompressionLevel Optimal -Force

    Get-ChildItem -Path $BackupFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Recurse
}
