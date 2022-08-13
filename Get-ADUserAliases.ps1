#Gets multiple aliases for 1 AD user
Get-ADUser -Identity username -Properties proxyaddresses | Select-Object Name, @{L = "ProxyAddresses"; E = { ($_.ProxyAddresses -like 'smtp:*') -join ";"}} | ConvertTo-HTML | Out-File alias.htm
#Then use Invoke Item to view
Invoke-Item alias.htm
