If (!(Get-module ActiveDirectory )) {
  Import-Module ActiveDirectory
  Clear-Host
  }
while($true){
$menu = Read-Host "Escribe las siguientes opciones del script:

1. Modificar datos del ordenador para que sean los mismos que los del ejercicio Cas Practic de M06
2. Instalar Active Directory en Windows Server (Requiere reinicio)
3. Importar csv
5. Exit
>"
Switch($menu){
 1{Rename-Computer -ComputerName "IVAN" -NewName "SERVER-PEREZ" -LocalCredential RemoteComputerAdminUser -Force

New-NetIPAddress -InterfaceIndex 1 -IPAddress 192.168.1.105
Set-NetIPAddress -InterfaceIndex 1 -IPAddress 192.168.1.105 -PrefixLength 24

Set-DnsClientServerAddress -InterfaceIndex 11 -ServerAddresses "192.168.1.105"}
 2{Install-WindowsFeature -Name "RSAT-AD-PowerShell" –IncludeAllSubFeature
Import-Module ActiveDirectory

Add-WindowsFeature AD-Domain-Services
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName "PEREZ.local" -InstallDNS
shutdown -r -t 1}
 3{$csvlocation = Read-Host "Escribe la ruta del csv (incluyendo el nombre del fichero y el formato csv)
 Ejemplo: C:\Carpeta\Fichero.csv
 > "

$Users=Import-csv $csvlocation -Encoding UTF8
ForEach($User in $Users){
$usuari=$user.usuari
$UO=$user.UO
$grup=$user.grup
$path='OU='+$UO+',DC=PEREZ,DC=local'
$password="L@laL030"

$Password = (ConvertTo-SecureString -AsPlainText $Password -Force)
$Parameters = @{
    'SamAccountName'        = $user.usuari
    'UserPrincipalName'     = $user.usuari
    'Name'                  = $user.nom
    'DisplayName'           = $user.nom
    'GivenName'             = $user.usuari 
    'Surname'               = $user.cognoms 
    'AccountPassword'       = $Password 
    'ChangePasswordAtLogon' = $false
    'Enabled'               = $true
    'Path'                  = $path
    }
if (!(get-adorganizationalunit -Filter 'Name -like $UO')){
  #Si la UO no existe, la crea
  New-ADOrganizationalUnit -Name $UO -Path "DC=PEREZ,DC=local"
  Write-Output "Creada Unidad Organizativa..."
}
if (!(get-adgroup -Filter 'Name -like $grup')) {
#Si el grupo no existe, lo crea
New-ADGroup -Name $grup -SamAccountName $grup -GroupCategory Security -GroupScope Global -DisplayName $grup -Path $path
Write-Output "Creado grupo correspondiente..."
}
if (!(get-aduser -Identity $usuari)){
#Se genera el usuario y se añade a un grupo
New-ADUser @Parameters -PassThru | % {Add-ADGroupMember -Identity $grup -Members $_}
Write-Output "Usuarios creados y añadidos a su grupo correspondiente..."
}
if ((Get-ADUser $usuari -Properties memberof).memberof -like "*FACTURACIO*") {
#Si facturacio está en la linea del csv, el usuario se generará desactivado.
Disable-ADAccount -Identity $usuari
Write-Output "Usuarios que pertenecen a FACTURACIO deshabilitados..."
}
Write-Output "Completado! Comprueba Active Directory."
}
}
 5{exit}
}
}