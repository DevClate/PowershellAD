#Create Security Group
#Created 5/3/2022
#Change the OU path if neccesary

[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='Name of Security Group')]
    [string]$Name,

    [Parameter(Mandatory,HelpMessage='Display Name of Security Group')]
    [string]$DisplayName,

    [Parameter(HelpMessage='Description of Security Group')]
    [string]$Description,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

New-ADGroup -Name $Name -Credential $Credentials -SamAccountName $Name -GroupCategory Security -GroupScope Global -DisplayName $DisplayName -Path "OU=Security Groups,DC=domain,DC=local" -Description $Description -Confirm
