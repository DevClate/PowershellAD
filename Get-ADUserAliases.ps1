[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to view Aliases')]
    [string]$Identity,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

#Gets multiple aliases for 1 AD user
Get-ADUser -Identity $Identity -Credential $Credential -Properties proxyaddresses | Select-Object Name, @{L = "ProxyAddresses"; E = { ($_.ProxyAddresses -like 'smtp:*') -join ";"}} | ConvertTo-HTML | Out-File alias.htm
#Then use Invoke Item to view
Invoke-Item alias.htm
