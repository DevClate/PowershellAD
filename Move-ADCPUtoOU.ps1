#Identity is original location, and Targetpath is destination
Move-ADObject -Identity "CN=CPUtoMove,OU=Workstations,DC=domain,DC=local" -TargetPath "OU=LocationyouwantCPUtogo,OU=Workstations,DC=domain,DC=local"
