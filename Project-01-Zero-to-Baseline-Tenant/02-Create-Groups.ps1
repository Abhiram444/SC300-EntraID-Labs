# IT

New-MgGroup `
-DisplayName "GRP-IT-Admins" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "grpitadmins"

# HR

New-MgGroup `
-DisplayName "GRP-HR-Team" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "grphrteam"

# Sales

New-MgGroup `
-DisplayName "GRP-Sales-Team" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "grpsalesteam"

# Finance

New-MgGroup `
-DisplayName "GRP-Finance-Team" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "grpfinanceteam"

# Marketing

New-MgGroup `
-DisplayName "GRP-Marketing-Team" `
-MailEnabled:$false `
-SecurityEnabled:$true `
-MailNickname "grpmarketingteam"

# Verify

Get-MgGroup |
Select DisplayName
