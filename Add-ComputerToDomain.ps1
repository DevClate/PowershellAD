#Add Computer to Domain
[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Enter Domain Name')]
    [string]$DomainName,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)
Add-Computer -DomainName $DomainName -Credential $Credential -Restart -Force