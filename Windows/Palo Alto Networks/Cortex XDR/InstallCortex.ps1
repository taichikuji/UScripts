#Requires -RunAsAdministrator

$list = "$(Get-Location)\Cortex.msi"
$isInstalled = "C:\Program Files\Palo Alto Networks\Traps"

if (Test-Path -Path $isInstalled) {
    Write-Host "$isInstalled found, running Cytool..."
    $installerPath = Get-ChildItem -Path $isInstalled -Filter '*CyTool*.exe' -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if ($installerPath) {
        Write-Host "Disabling Cortex..."
        do {
            $dis = Start-Process -FilePath $installerPath.FullName -ArgumentList "protect disable" -Wait -PassThru -NoNewWindow
        } until ($dis.ExitCode -ne 5)
    } else {
        Write-Host "CyTool.exe not found."
        Exit 1
    }
}

Write-Host "Attempting to install $list ..."

$dis = Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $list /passive /L*v $(Get-Location)\msiexec.log" -Wait -PassThru -ErrorAction Stop
if (@(0, 3010) -contains $dis.ExitCode) {
    Write-Host "Installation was successful and finished with Exit code $($dis.ExitCode)!"
} else {
    Write-Host "Error installing $list"
    Exit 1
}

Write-Host "Done! Closing script"
Exit 0