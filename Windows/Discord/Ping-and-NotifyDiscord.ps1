Function Send-Message
{
    param([String]$webhook, [PSCustomObject]$embedObject)
    [System.Collections.ArrayList]$embedArray = @()
    $embedArray.Add($embedObject) | Out-Null
    $payload = [PSCustomObject]@{
        embeds = $embedArray
    }
    try {Invoke-RestMethod -Uri $webhook -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'}
    catch {Write-Host "$($_.Exception.Message)"}
}

Function Count-Up
{
    param([string]$url, [string]$webhook)
        try {$StatusCode = $(Invoke-WebRequest -URI $url -Method 'GET').StatusCode}catch{$StatusCode = $_.Exception.Response.StatusCode.Value__}
        if($StatusCode -eq 200) {
            $embedObject = [PSCustomObject]@{
                color = '4289797'
                title = "$url | $StatusCode"
                description = "$url is now available with the following status code: $StatusCode"
            }
        } else {
            $embedObject = [PSCustomObject]@{
                color = 'DC143C'
                title = "$url | $StatusCode"
                description = "$url has the following status code: $StatusCode"
            }
        }
        Send-Message -webhook $webhook -embedObject $embedObject
        exit 0
    }

Count-Up -url https://<>/ -webhook https://discord.com/api/webhooks/<>/<>/