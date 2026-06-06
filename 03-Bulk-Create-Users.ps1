# Generate 100 users

$users = Invoke-RestMethod `
"https://randomuser.me/api/?results=100"

foreach ($u in $users.results)
{
    $FirstName = $u.name.first
    $LastName  = $u.name.last

    $mailNick = ($FirstName + $LastName).ToLower()
    $mailNick = $mailNick -replace '[^a-z0-9]', ''

    $random = Get-Random -Maximum 9999

    $UPN = "$mailNick$random@rabhi060gmail.onmicrosoft.com"

    try
    {
        New-MgUser `
        -DisplayName "$FirstName $LastName" `
        -GivenName $FirstName `
        -Surname $LastName `
        -UserPrincipalName $UPN `
        -MailNickname "$mailNick$random" `
        -AccountEnabled `
        -PasswordProfile @{
            Password = "P@ssw0rd123!"
        }

        Write-Host "Created: $UPN"
    }
    catch
    {
        Write-Host "Failed: $UPN"
    }
}

# Verify

(Get-MgUser -All).Count

