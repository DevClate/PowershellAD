[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string[]]
    $User
    )
    

$Groups = Get-ADgroup -Filter * | Select-Object -Property Name| 
Out-GridView -PassThru -Title "Select the Groups you want to add the users" | 
Select-Object -ExpandProperty Name

foreach($group in $groups){
    Add-ADGroupMember -Identity $group -Members $user
}