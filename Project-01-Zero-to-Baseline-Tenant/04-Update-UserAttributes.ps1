# Update User Attributes

Update-MgUser `
-UserId "abhi.user1@rabhi060gmail.onmicrosoft.com" `
-Department "IT" `
-City "Hyderabad" `
-JobTitle "System Administrator"

# Verify

Get-MgUser `
-UserId "abhi.user1@rabhi060gmail.onmicrosoft.com" |
Select DisplayName,
Department,
City,
JobTitle

