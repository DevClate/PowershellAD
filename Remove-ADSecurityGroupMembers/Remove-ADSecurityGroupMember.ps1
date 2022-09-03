#Remove users from security group in AD

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [ValidateSet("Superintendent", "ProjectEngineer", "ProjectManager")]
    [string]
    $JobTitle,
    
    [Parameter(Mandatory)]
    [string]
    $Members,

    $Path = ".\DL\$jobtitle.csv",

    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [System.Management.Automation.PSCredential]
    [System.Management.Automation.Credential()]
    $Credential = [System.Management.Automation.PSCredential]::Empty

)

Remove-ADGroupMember -Credential $Credential -Identity $Identity -Members $Members

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

Read-Host -Prompt "Press Enter to exit"
