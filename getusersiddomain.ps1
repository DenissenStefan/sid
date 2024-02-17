# Import the Active Directory module
Import-Module ActiveDirectory

# prompt for the domain name
$domainname = Read-Host "Enter the domain name"

# Convert the domain name to the distinguished name format
$domain = "$domainname"
$dc = $domain -replace '\.', ',DC='
$dcDN = "DC=$dc"

# prompt for the OU name
$ouname = Read-Host "Enter the OU name"

# Specify the OU distinguished name
$ouDN = "OU=$ouname,$dcDN"

# Get all the users below the specified OU
$users = Get-ADUser -SearchBase $ouDN -Filter * -Properties *

# Get the location of the script file
$path = $PSScriptRoot

# Create an empty array to store user information
$userInfo = @()

# Iterate through each user and retrieve the SID
foreach ($user in $users) {
    $sid = $user.SID
    $userInfo += [PSCustomObject]@{
        User = $user.Name
        SID = $sid
    }
}

# Export the user information to a CSV file
$userInfo | Export-Csv -Path "$path\users.csv" -NoTypeInformation

# Display a message to indicate the location of the saved CSV file
Write-Host "User information has been saved to $path\users.csv"