:: Set directory for installation - Chocolatey does not lock 
:: down the directory if not the default
SET INSTALLDIR=c:\ProgramData\chocoportable
setx ChocolateyInstall %INSTALLDIR%

:: All install options - offline, proxy, etc at
:: https://chocolatey.org/install
@powershell -NoProfile -ExecutionPolicy Bypass -Command "(iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))) >$null 2>&1" && SET PATH="%PATH%;%INSTALLDIR%\bin"

CALL choco install puppet-agent.portable -y
CALL choco install ruby.portable -y
CALL choco install git.commandline -y

:: pick an editor
::CALL choco install visualstudiocode.portable -y :: Not available yet
CALL choco install notepadplusplus.commandline -y
::CALL choco install nano -y
::CALL choco install vim-tux.portable

:: What else can I install without admin rights?
:: https://chocolatey.org/packages?q=id%3Aportable