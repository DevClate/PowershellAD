[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $UserPrincipalName,
    [Parameter(Mandatory)]
    [ValidateSet("Superintendent", "ProjectEngineer", "ProjectManager")]
    [string]
    $JobTitle,
    [Parameter(Mandatory)]
    [string]
    $Member,
    $Path = ".\DL\$jobtitle.csv"

)

Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName
Import-CSV -Path $Path | ForEach-Object {  
    $GroupUPN=$_.GroupUPN 
    Write-Progress -Activity "Adding user to $GroupUPN… "  
    Add-DistributionGroupMember –Identity $GroupUPN -Member $Member  
    If($?)  
    {  
    Write-Host User successfully added to $GroupUPN -ForegroundColor Green  
    }  
    Else  
    {  
    Write-Host Error occurred while adding user to $GroupUPN –ForegroundColor Red  
    }  
}

Disconnect-ExchangeOnline