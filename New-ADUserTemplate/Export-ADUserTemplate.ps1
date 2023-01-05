$ADUserInfo = Read-Host "Enter user name for copy for template"
$FileName = Read-Host "Template name"

# Create empty array
$AllADUsers = @()

# Loop through every DN
foreach ($DN in $ADUserInfo) {
    $Users = Get-ADUser $ADUserInfo -Properties * 

    # Add users to array
    $AllADUsers += $Users
}

$AllADUsers | Sort-Object Name | Select-Object `
@{Label = "First name"; Expression = { $_.GivenName } },
@{Label = "Last name"; Expression = { $_.Surname } },
@{Label = "Display name"; Expression = { $_.DisplayName } },
@{Label = "User logon name"; Expression = { $_.SamAccountName } },
@{Label = "User principal name"; Expression = { $_.UserPrincipalName } },
@{Label = "Street"; Expression = { $_.StreetAddress } },
@{Label = "City"; Expression = { $_.City } },
@{Label = "State/province"; Expression = { $_.State } },
@{Label = "Zip/Postal Code"; Expression = { $_.PostalCode } },
@{Label = "Country/region"; Expression = { $_.Country } },
@{Label = "Job Title"; Expression = { $_.Title } },
@{Label = "Department"; Expression = { $_.Department } },
@{Label = "Company"; Expression = { $_.Company } },
@{Label = "Manager"; Expression = { % { (Get-AdUser $_.Manager -Properties DisplayName).DisplayName } } },
@{Label = "Description"; Expression = { $_.Description } },
@{Label = "Office"; Expression = { $_.Office } },
@{Label = "Office Phone"; Expression = { $_.OfficePhone } },
@{Label = "Telephone number"; Expression = { $_.telephoneNumber } },
@{Label = "E-mail"; Expression = { $_.Mail } },
@{Label = "Mail Nickname"; Expression = { $_.mailNickname } },
@{Label = "Mobile"; Expression = { $_.mobile } },
@{Label = "Notes"; Expression = { $_.info } },
@{Label = "Home Directory"; Expression = { $_.HomeDirectory } },
@{Label = "Home Drive"; Expression = { $_.HomeDrive } },
@{Label = "Home Page"; Expression = { $_.HomePage } },
@{Label = "Logon Script"; Expression = { $_.ScriptPath } } |
 
# Export report to CSV file
Export-Csv -Encoding UTF8 -Path ".\$FileName.csv" -NoTypeInformation #-Delimiter ";"

Read-Host -Prompt "Press Enter to exit"