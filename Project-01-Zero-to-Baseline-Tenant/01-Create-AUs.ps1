# Create Administrative Units

New-MgDirectoryAdministrativeUnit `
-DisplayName "AU-Hyderabad" `
-Description "Hyderabad Office Users"

New-MgDirectoryAdministrativeUnit `
-DisplayName "AU-Bangalore" `
-Description "Bangalore Office Users"

New-MgDirectoryAdministrativeUnit `
-DisplayName "AU-Pune" `
-Description "Pune Office Users"

# Verify

Get-MgDirectoryAdministrativeUnit |
Select DisplayName,Description
