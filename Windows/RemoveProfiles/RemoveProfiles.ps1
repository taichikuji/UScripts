Write-Host "Removing profiles..."
Get-CimInstance -class Win32_UserProfile | Where-Object {
    (!$_.Special)
} | Remove-CimInstance
Write-Host "Removed! Exiting..."