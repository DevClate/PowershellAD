# Import active directory module for running AD cmdlets
Import-Module ActiveDirectory
  
# Store the data from NewHire-Template.csv in the $ADUsers variable
$ADUsers = Import-Csv "C:\scripts\NewHire-Template.csv"

# Define Domain
$Domain = "yourdomain.com"

# Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

    #Read user data from each field in each row and assign the data to a variable as below
    $username = $User.UserName
    $password = $User.password
    $firstname = $User.firstname
    $lastname = $User.lastname
    $initials = $User.initials
    $OU = $User.ou #This field refers to the OU the user account is to be created in
    $email = $User.email
    $streetaddress = $User.streetaddress
    $city = $User.city
    $zipcode = $User.postalcode
    $state = $User.state
    $telephone = $User.officephone
    $mobilephone = $User.mobilephone
    $jobtitle = $User.jobtitle
    $company = $User.company
    $department = $User.department
    $homepage = $User.website
    $HomeDirectory = $User.HomeDirectory
    $HomeDrive = $User.HomeDrive
    $ScriptPath = $User.LogonScript
    $mailnickname = $User.mailnickname

    # Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        $newUserParams = @{
            GivenName           = $firstname
            Surname             = $lastname
            Name                = "$firstname $lastname"
            DisplayName         = "$firstname $lastname"
            Initials            = $initials
            SamAccountName      = $username
            UserPrincipalName   = "$username@$Domain"
            EmailAddress        = $email
            Title               = $jobtitle
            StreetAddress       = $streetaddress
            City                = $city
            State               = $state
            PostalCode          = $zipcode
            Country             = $country
            Company             = $company
            OfficePhone         = $telephone
            MobilePhone         = $mobilephone
            Path                = $OU
            HomePage            = $HomePage
            Department          = $department
            HomeDirectory       = $HomeDirectory
            HomeDrive           = $HomeDrive
            Enabled             = $True
        }
        
        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser @newUserParams -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force)
        
        #Sets Mailnickname and Logon Script
        Set-ADUser -identity $username -Replace @{mailnickname="$mailnickname"; ScriptPath="$scriptpath"}

        # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"
