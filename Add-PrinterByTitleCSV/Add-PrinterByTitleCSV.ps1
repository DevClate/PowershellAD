# Left off how to add in groups with CSV and going to use the jobtitle to change
# the file for the printers to pul

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string[]]
    $User,
    [Parameter(Mandatory)]
    [string]
    $JobTitle,
    $Path = ".\Printers\$jobtitle.csv"
    
)

$group = Import-CSV -Path $Path | ForEach-Object {
    $Group=$_.SecurityGroup
    Write-Progress -Activity "Adding user to $Group..."
    Add-ADGroupMember -Identity $Group -Members $User
    If($?)
    {
        Write-Host User successfully added to $Group -ForegroundColor Green
    }
    else 
    {
        Write-Host Error occurred while adding user to $Group -ForegroundColor Red
    }

}