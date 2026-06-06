# Create Delegated Admin

$password = @{
    Password = "P@ssw0rd123!"
}

New-MgUser `
-DisplayName "Hyd HR Admin" `
-UserPrincipalName "hyd.hr.admin@rabhi060gmail.onmicrosoft.com" `
-MailNickname "hydhradmin" `
-AccountEnabled `
-PasswordProfile $password

# Verify

Get-MgUser `
-UserId "hyd.hr.admin@rabhi060gmail.onmicrosoft.com"
