# Importing AD module
Import-Module ActiveDirectory

# Get all members of the roaming profile group
Get-ADGroupMember 'Roaming Profile Users' |
    # Loop through each user
    ForEach-Object {
        # Do this for each member
        Set-ADUser -Identity $_.SamAccountName -ProfilePath ("\\ANTDOMAIN1\Profiles$\" + $_.SamAccountName)
    }