$dir = "c:\temp"
$upgradeUrl = "https://go.microsoft.com/fwlink/?LinkID=799445"
$upgradeFilePath = Join-Path -Path $dir -ChildPath "Win10Upgrade.exe"

function Create-Directory {
    param (
        [string]$dirPath
    )
    if (-Not (Test-Path -Path $dirPath)) {
        New-Item -Path $dirPath -ItemType Directory -ErrorAction Stop
    } else {
        Write-Output "Folder already exists! Script should continue."
    }
}

function Download-File {
    param (
        [string]$url,
        [string]$outputPath
    )
    try {
        (New-Object System.Net.WebClient).DownloadFile($url, $outputPath)
    } catch {
        Write-Output "Failed to download file: $_.Exception"
        Exit
    }
}

function Run-Upgrade {
    param (
        [string]$filePath
    )
    Start-Process -FilePath $filePath -PassThru
}

try {
    Create-Directory -dirPath $dir
    Download-File -url $upgradeUrl -outputPath $upgradeFilePath
    Run-Upgrade -filePath $upgradeFilePath
} catch {
    Write-Output $_.Exception
    Exit
}