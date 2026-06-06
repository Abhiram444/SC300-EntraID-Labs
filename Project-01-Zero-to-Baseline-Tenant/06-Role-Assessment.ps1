# Enumerate Roles

Get-MgRoleManagementDirectoryRoleDefinition |
Select-Object DisplayName, IsBuiltIn |
Sort-Object DisplayName

# Check Custom Roles

Get-MgRoleManagementDirectoryRoleDefinition |
Where-Object {$_.IsBuiltIn -eq $false}

