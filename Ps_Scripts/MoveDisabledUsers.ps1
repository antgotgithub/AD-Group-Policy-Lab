#Import AD odule
Import-Module ActiveDirectory

#List all AD disbaled users
Search-ADAccount -AccountDisabled | Where {$_.DistinguishedName -notlike "OU=Disabled Users"} | Select-Object Name, DistinguishedName

#Move all disabled users to own ou
Search-ADAccount -AccountDisabled | Move-ADObject -TargetPath "OU=Disabled Users,OU=Antdomain,DC=Antdomain,DC=com"

