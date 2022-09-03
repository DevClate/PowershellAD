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
    Write-Progress -Activity "Removing user from $GroupUPN… "  
    Remove-DistributionGroupMember –Identity $GroupUPN -Member $Member -Confirm:$false 
    If($?)  
    {  
    Write-Host User successfully removed from $GroupUPN -ForegroundColor Green  
    }  
    Else  
    {  
    Write-Host Error occurred while removing user from $GroupUPN –ForegroundColor Red  
    }  
} 
Disconnect-ExchangeOnline