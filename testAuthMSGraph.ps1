# Install the Microsoft Graph PowerShell SDK if not already installed
try {
    Write-Output "Checking if Microsoft Graph PowerShell SDK is installed..."
    if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
        Write-Output "Installing Microsoft Graph PowerShell SDK..."
        Install-Module Microsoft.Graph -Scope CurrentUser -ErrorAction Stop
        Write-Output "Microsoft Graph PowerShell SDK installed successfully."
    } else {
        Write-Output "Microsoft Graph PowerShell SDK is already installed."
    }
} catch {
    Write-Error "Failed to install Microsoft Graph PowerShell SDK: $_"
    exit
}

# Prompt the user to log in
try {
    Write-Output "Connecting to Microsoft Graph..."
    Connect-MgGraph -Scopes "User.Read.All", "Group.Read.All" -ErrorAction Stop
    Write-Output "Connected to Microsoft Graph successfully."
} catch {
    Write-Error "Failed to connect to Microsoft Graph: $_"
    exit
}

# Get all users and print their names in a table
try {
    Write-Output "Retrieving users from Microsoft Graph..."
    $users = Get-MgUser -All -ErrorAction Stop
    Write-Output "Users retrieved successfully. Displaying user names:"
    $users | Format-Table DisplayName
} catch {
    Write-Error "Failed to retrieve users: $_"
}
