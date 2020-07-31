 $data = (Get-Date -Format "MMddyyyy_HHmm")
 
Write-Output "Este Script ha sido creado por Ivan Perez Fernandez."
Write-Output "Fue creado con el proposito de ser usado como herramienta para escanear puertos y detectar Dispositivos"
Write-Output "`nLa forma en la que funciona es la siguiente;`nTiene esta tabla de valores: 192.168.<>.<>"
Write-Output "Y se preguntara por los valores. Una vez se introduzcan los valores, se empezara a ejecutar el script."
Write-Output "Se guardaran los valores en .\Ping_Data-$data.txt"
[byte]$starti = Read-Host "Introduce el numero inicial (192.168.<>)"
[byte]$finishi = Read-Host "Introduce el numero final (192.168.<>)"
[byte]$startj = Read-Host "Introduce el numero inicial (192.168.$starti.<>)"
[byte]$finishj = Read-Host "Introduce el numero final (192.168.$starti.<>)"
$resp = Read-Host "El rango a ejecutar sera el siguiente:`n192.168.$starti.$startj - 192.168.$finishi.$finishj`nEstas seguro? (Y/N)"
if ($resp -eq "Y"){
    For ($i = $starti; $i -lt $finishi; $i++) {
        For ($j = $startj; $j -lt $finishj; $j++){
            if ((Test-Connection -ComputerName 192.168.$i.$j -Quiet -Count 1) -eq "True") {
                echo "$($i).$($j) is true"
                Test-NetConnection -CommonTCPPort HTTP -ComputerName 192.168.$i.$j -InformationLevel Detailed | Out-File -FilePath .\Ping_Data-$data.txt -Append
            }else{
                echo "$($i).$($j) is false"
            }
        }
    }
} else { exit }