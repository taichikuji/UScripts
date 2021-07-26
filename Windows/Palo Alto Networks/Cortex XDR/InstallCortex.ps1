#Requires -RunAsAdministrator

#Script will disable the CORTEX XDR service, and install the program through the msi provided by the user.

# Requires cortex msi file for it to work.
$list = "$(Get-Location)\Cortex.msi"
$isInstalled = "C:\Program Files\Palo Alto Networks\Traps"
# Checks if the program is installed
If (Test-Path -Path $isInstalled) {
    Write-Host "$isInstalled found, running Cytool..."
    $filename = '*CyTool*'
    # Finds Cytool.exe and tries to disable cortex with it
    ForEach ( $Installer in ( Get-ChildItem -Path $isInstalled -Filter $filename -Recurse -Include *.exe -ErrorAction SilentlyContinue ) ) {
        # This asks for input to disable cortex
        Write-Host "Disabling Cortex..."
        # Run until loop until it is disabled
        do {
            $dis = $(Start-Process $Installer -ArgumentList "protect disable" -Wait -PassThru -NoNewWindow)
        } until ( -not $($dis.ExitCode-eq 5))
    }
}
Write-Host "Attempting to install $list ..."

# Installs the .msi file
$dis = Start-Process "msiexec.exe" -ArgumentList $("/i $list /passive /L*v $(Get-Location)\msiexec.log") -Wait -PassThru -ErrorAction Stop
If (@(0, 3010) -contains $dis.ExitCode) {
    Write-Host "Installation was succesful and finished with Exit code $($dis.ExitCode)!"
} else {
    Write-Host "Error installing $list"
    Break
}

Write-Host "Done! Closing script"
Exit 0