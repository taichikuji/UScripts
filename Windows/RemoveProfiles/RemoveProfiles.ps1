Write-Host "Removing profiles..."
$profiles = Get-CimInstance -ClassName Win32_UserProfile | Where-Object {
    -not $_.Special
}
if ($profiles) {
    $profiles | ForEach-Object { $_ | Remove-CimInstance }
    Write-Host "Removed! Exiting..."
} else {
    Write-Host "No profiles found to remove. Exiting..."
}