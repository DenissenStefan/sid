# Get all user accounts
$users = Get-WmiObject -Class Win32_UserAccount

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