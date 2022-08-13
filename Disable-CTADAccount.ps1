[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to disable')]
    [string]$Identity,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Disable-ADAccount -Identity $Identity -Credential $Credential