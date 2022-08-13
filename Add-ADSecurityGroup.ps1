#Create Security Group
#Created 5/3/2022
$Credentials = Get-Credential
New-ADGroup -Name "Security Group Name" -Credential $Credentials -SamAccountName SecurityGroupName -GroupCategory Security -GroupScope Global -DisplayName "Security Group Name" -Path "OU=Security Groups,DC=domain,DC=local" -Description "Description of Security Group" -Confirm
