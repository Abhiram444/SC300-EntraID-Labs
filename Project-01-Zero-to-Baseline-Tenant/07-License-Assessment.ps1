# Check Tenant Licenses

Get-MgSubscribedSku

# Export License Report

Get-MgUser |
Select DisplayName,
UserPrincipalName,
AssignedLicenses |
Export-Csv `
".\LicenseReport.csv" `
-NoTypeInformation
