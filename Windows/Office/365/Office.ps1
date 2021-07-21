# Script will try to download Office through a config.xml file, then install it once it's done. 
Try {
    # Downloads Office through the config.xml file
    If(-not(Get-ChildItem "Office" -ErrorAction SilentlyContinue)){
        Write-Host "Office not downloaded, downloading..." # Downloading if not already present
        Start-Process -FilePath "$PSScriptRoot\setup.exe" -ArgumentList "/download .\config.xml" -Wait -PassThru
    }
    # Runs the Office setup through the config.xml file
    Start-Process -FilePath "$PSScriptRoot\setup.exe" -ArgumentList "/configure .\config.xml" -PassThru
} Catch {
    Write-Host "Exception was found, skipping installation..."
    Write-Host $_.Exception.Message
    Exit 0
}