# Import AD module
Import-Module ActiveDirectory

# Grab variables from user
$firstname = Read-Host -Prompt "Enter first name"
$lastname  = Read-Host -Prompt "Enter last name"

# Build account name (capital first initial + lastname)
$firstInitial = $firstname.Substring(0,1).ToUpper()
$sam = $firstInitial + $lastname
$upn = "$sam@antdomain.com"

# Create AD User
New-ADUser `
    -Name "$firstname $lastname" `
    -GivenName $firstname `
    -Surname $lastname `
    -SamAccountName $sam `
    -UserPrincipalName $upn `
    -AccountPassword (ConvertTo-SecureString "Admin12$" -AsPlainText -Force) `
    -Path "OU=Domain users,OU=Antdomain,DC=Antdomain,DC=com" `
    -ChangePasswordAtLogon $true `
    -Enabled $true
