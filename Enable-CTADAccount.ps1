[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to Enable')]
    [string]$Identity,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Enable-ADAccount -Identity $Identity -Credential $Credential