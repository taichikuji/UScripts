$env:chocolateyUseWindowsCompression='true'
$env:ChocolateyInstall="$home\choco"
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
choco --version