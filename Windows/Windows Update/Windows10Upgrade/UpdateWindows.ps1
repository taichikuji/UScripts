# Script will try to download and run the Windows 10 Upgrader tool unattendingly.

$dir = "c:\temp"
Try {
    # Create temp directory
    New-Item -Path $dir -ItemType Directory -ErrorAction Stop
} Catch [System.IO.IOException] {
    Write-Output "Folder already exists! Script should continue."
    Break
} Catch {
    Write-Output $_.Exception
    Exit
}
# Download upgrade file
$(New-Object System.Net.WebClient).DownloadFile("https://go.microsoft.com/fwlink/?LinkID=799445",$("$($dir)\Win10Upgrade.exe"))

# Runs upgrade file
Start-Process -FilePath $file -PassThru