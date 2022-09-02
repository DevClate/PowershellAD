# How to Create New AD Users from CSV
## The Intro
Tired of always trying to remember which fields you need to enter in AD and clicking through all the different tabs to fill them out? Or need consistency on how the AD fields are filled out from all techs? Or need HR to fill out the fields they know, then you just add the "IT" fields? This little script is for you. I'll walk you through each step of the way, and if you have any questions feel free to reach out.
## The Prep
1. Find the fields you want to include in your template
   1. I recommend finding an already created user who fits the template you want to use - and write down those fields to start with
2. Export that User to CSV to see how they are entered
3. Create a CSV (Named NewHire-Template.csv) with the header names of the fields you want to populate
4. Input test user information
## The Script
1. Open up your favorite Powershell editor(I'm using VSCode which I'd highly recommend)
2. Create a file name "Add-ADUserCSVTemplate.ps1"
3. First we need to make sure we have the ActiveDirectory Module

   ```Powershell
   #Import active directory module for running AD cmdlets 
   Import-Module ActiveDirectory
   ```

4. Import the users information from the CSV you created earlier NewHire-Template.csv - Feel free to change the location if needed

   ```Powershell
    #Store the data from NewHire-Template.csv in the $ADUsers variable
    $ADUsers = Import-Csv "C:\scripts\NewHire-Template.csv"
    ```

5. Define your UserPrincipleName, this will be your email domain

    ```Powershell
    # Define Domain
    $Domain = "yourdomain.com"
    ```

6. Now we will match the CSV Headers with the AD Attributes and import them in for each user.

    ```Powershell
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
    ```

7. Lets check to make sure the user isn't already there - This searches for the username as the SamAccountName and if it exists state it already exists

```Powershell
# Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
```
8. If user hasn't been created, use the below information

```Powershell
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
  ```
      
9. Create new user while not showing the password in plain text
      
```Powershell
       # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser @newUserParams -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force)
 ```
      
10.  Once user is created set the mailnickname and login script fields. I haven't found an easy way to put it in the above parameters so that is why I have it seperated out here.
      
```Powershell
        #Sets Mailnickname and Logon Script
        Set-ADUser -identity $username -Replace @{mailnickname="$mailnickname"; ScriptPath="$scriptpath"}
```
11. Now that we have all of the standard information and the new user is created, display that the user is created
      
```Powershell
       # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}
```
        
12. Then I like to put a pause at the end so I can see what was created and can exit when I want to
        
```Powershell
        Read-Host -Prompt "Press Enter to exit"
```
## Conclusion
You did it! You created your first script to import bulk users into AD in there correct OU with all
fields filled out. Now you or your colleagues do not have to guess what fields need to be filled out.
Feel free to add/remove fields for your organization. What I would recommend if you have multiple OUs and locations is to create a CSV or if you have documentation for each role and copy the AD field information for that user so you don't have to keep typing it. Eventually, I'll have it automatically input from just typing in a number that is associated for that OU and for that location. If you only have one location, you could pre set that location and not need to put it into the CSV.
## Next Steps
A few ideas you could add besides the couple I just mentioned
- Add to security groups
- Add to distribution groups
- Email HR that the email is ready
- Add licensing
- Trigger next step in the process
  
Tell me what you think and let me know how you changed it!
