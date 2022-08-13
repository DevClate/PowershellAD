#Change user's PW in AD
#Created 4/13/2022

[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to change password')]
    [string]$Identity,

    [Parameter(Mandatory,HelpMessage='Enter New Password')]
    [securestring]$NewPwd,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Set-ADAccountPassword -Identity $Identity -NewPassword $NewPwd -Reset -Credential $Credential
