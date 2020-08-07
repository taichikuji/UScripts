Write-Output "With PowerShell, you must ensure Get-ExecutionPolicy is not Restricted. We suggest using Bypass to bypass the policy to get things installed or AllSigned for quite a bit more security."
Write-Output "Run Get-ExecutionPolicy. If it returns Restricted, then run Set-ExecutionPolicy AllSigned or Set-ExecutionPolicy Bypass -Scope Process."
Write-Output "If you already did this, ignore this text.`nExecuting script..."
Start-Sleep -Seconds 1
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
Start-Sleep -Seconds 1
Write-Output "If you don't see any errors, you are ready to use Chocolatey! Type choco or choco -? now."

Update-SessionEnvironment

Write-Output "From this point forward, multiple packages will be installed, please wait..."
Start-Sleep -Seconds 1
choco install chocolateygui -y
choco install jdk8 -params "both=true" -y
choco install microsoft-teams -y
choco install teamviewer --ignore-checksums -y
choco install anydesk -y
choco install 7zip -y
choco install adobereader -params '"/DesktopIcon /UpdateMode:3"' -y
choco install googlechrome -y
choco install microsoft-edge -y
choco install office365business -params '"/productid:O365ProPlusRetail /exclude:""Groove Lync OneNote OneDrive"""' -y
choco install keepass -y
choco upgrade all -y

Write-Output "Installation has finished!"
Start-Sleep -Seconds 1
Exit