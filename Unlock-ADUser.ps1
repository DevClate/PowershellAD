#Documentation https://www.techrepublic.com/article/11-powershell-commands-to-use-in-managing-active-directory
[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to unlock')]
    [string]$Identity,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Unlock-ADAccount -Identity $Identity -Credential $Credential
