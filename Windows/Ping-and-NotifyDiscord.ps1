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
    while($i -lt 9999)
    {
        $i++
        try {$StatusCode = $(Invoke-WebRequest -URI $url -Method 'GET').StatusCode}catch{$StatusCode = $_.Exception.Response.StatusCode.value__}
        if($StatusCode -eq 200) {
            $embedObject = [PSCustomObject]@{
                color = '4289797'
                title = "$i | $url | $StatusCode"
                description = "$url is now available with status code $StatusCode"
            }
            Send-Message -webhook $webhook -embedObject $embedObject
            exit 0
        }
        Write-Host "$i | $url | $StatusCode"
    }
}

Count-Up -url https://<> -webhook https://discord.com/api/webhooks/<>/<>