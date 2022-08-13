#AD - Hide in 365 Address book when using Azure AD Sync
#https://www.tachytelic.net/2017/11/office-365-hide-a-user-from-gal-ad-sync/

#Add mail nickname for hiding addressbook
#Documentation <https://social.technet.microsoft.com/Forums/lync/en-US/6811071e-f329-428e-a70d-8f05bbe61d1d/how-to-set-aduser-attribute-mailnickname?forum=winserverpowershell

[CmdletBinding()]
param (
    [Parameter(Mandatory,HelpMessage='User to hide from addressbook without @')]
    [string]$Identity,

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Get-ADUser -Identity $Identity -Properties MailNickName | Set-ADUser -Replace @{MailNickName = "$Identity"} -Credential $Credential

Set-ADUser -Identity $Identity -Replace @{msExchHideFromAddressLists=$true} -Credential $Credential
