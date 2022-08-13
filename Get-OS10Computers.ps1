#Exports and stays within powershell
Get-ADComputer -filter {operatingsystem -like "Windows 10*" } -Properties OperatingSystemVersion|select name,OperatingSystemVersion |sort OperatingSystemVersion -Descending


#Use this one to export to CSV
#Get-ADComputer -filter {operatingsystem -like "Windows 10*" } -Properties lastlogondate,OperatingSystemVersion|select name,OperatingSystemVersion,lastlogondate |sort OperatingSystemVersion -Descending | Export-Csv -Path .\Windows10.csv -NoTypeInformation
