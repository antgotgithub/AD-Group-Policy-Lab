# Import the AD Module
Import-Module ActiveDirectory

# Get the path to our target CSV file
$filepath = Read-Host -Prompt "Please enter the path to the CSV file that contains the new user accounts"

# Import the CSV as an array
$users = Import-CSV $filepath

# Complete an action for each user in the CSV file
ForEach ($user in $users) {
    # Build the UPN: First initial (capitalized) + Lastname (capitalized) + @Antdomain.com
    $firstInitial = $user.'First Name'.Substring(0,1).ToUpper()
    $lastName = ($user.'Last Name').Substring(0,1).ToUpper() + ($user.'Last Name').Substring(1).ToLower()
    $upn = $firstInitial + $lastName + "@Antdomain.com"

    # Create the AD user
    New-ADUser `
        -Name ($user.'First Name' + " " + $user.'Last Name') `
        -GivenName $user.'First Name' `
        -Surname $user.'Last Name' `
        -UserPrincipalName $upn `
        -SamAccountName ($firstInitial + $lastName) `
        -AccountPassword (ConvertTo-SecureString "Admin12$" -AsPlainText -Force) `
        -Description $user.Description `
        -EmailAddress $user.'Email Address' `
        -Title $user.'Job Title' `
        -OfficePhone $user.'Office Phone' `
        -Path "OU=Domain users,OU=Antdomain,DC=Antdomain,DC=com" `
        -ChangePasswordAtLogon $true `
        -Enabled ([System.Convert]::ToBoolean($user.Enabled))
}
