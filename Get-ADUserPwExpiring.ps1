#Searches Groups for Password Expiration
Get-ADUser -SearchBase 'OU=Company Users,DC=domain,DC=local' -filter * -properties PasswordExpired, PasswordLastSet, PasswordNeverExpires | ft Name, PasswordExpired, PasswordLastSet, PasswordNeverExpires
