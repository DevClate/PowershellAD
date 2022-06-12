#Searches Multiple Groups for Password Expiration
$OUs = "OU=Group2,OU=Company Users,DC=domain,DC=local","OU=Group1,OU=Company Users,DC=domain,DC=local"
$OUs | foreach {Get-ADUser -SearchBase $_ -Filter * -Properties PasswordExpired, PasswordLastSet | Select Name, PasswordExpired, PasswordLastSet, PasswordNeverExpires | ft Name, PasswordExpired, PasswordLastSet, PasswordNeverExpires}
