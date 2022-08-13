#Remove AD Computer 5/18/2022
[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Computer Name to remove')]
    [string]$Identity,
    
    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Remove-ADComputer -Identity $Identity -credential $Credential
