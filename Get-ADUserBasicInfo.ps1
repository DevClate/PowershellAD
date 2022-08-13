[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Username to get information')]
    [string]$Identity,

    [Parameter()]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty
)

Get-ADUser -Identity $Identity -properties CN, DisplayName, DistinguishedName, Department, EmailAddress, MemberOf, Title, mobile
