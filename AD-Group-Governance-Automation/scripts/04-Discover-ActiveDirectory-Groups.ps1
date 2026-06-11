<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 04-Discover-ActiveDirectory-Groups.ps1

Purpose :
Builds a complete inventory of enterprise groups by combining
group, owner and membership information.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "AD Group Discovery Engine"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$DataFolder = Join-Path $PSScriptRoot "..\data"

$GroupsFile = Join-Path $DataFolder "groups.csv"

$OwnersFile = Join-Path $DataFolder "owners.csv"

$MembersFile = Join-Path $DataFolder "memberships.csv"

$ReportsFolder = Join-Path $PSScriptRoot "..\reports"

if(!(Test-Path $ReportsFolder))
{
    New-Item -ItemType Directory -Path $ReportsFolder | Out-Null
}

#---------------------------------------------------
# Import Data
#---------------------------------------------------

$Groups = Import-Csv $GroupsFile

$Owners = Import-Csv $OwnersFile

$Members = Import-Csv $MembersFile

$Inventory = @()

#---------------------------------------------------
# Build Inventory
#---------------------------------------------------

foreach($Group in $Groups)
{

    $OwnerCount = ($Owners |
        Where-Object {$_.GroupID -eq $Group.GroupID}).Count

    $MemberCount = ($Members |
        Where-Object {$_.GroupID -eq $Group.GroupID}).Count

    $Inventory += [PSCustomObject]@{

        GroupID = $Group.GroupID

        GroupName = $Group.GroupName

        Department = $Group.Department

        GroupType = $Group.GroupType

        Status = $Group.Status

        OwnerCount = $OwnerCount

        MemberCount = $MemberCount

        DiscoveryDate = Get-Date

    }

}

#---------------------------------------------------
# Export
#---------------------------------------------------

$OutputFile = Join-Path $ReportsFolder "discovered-groups.csv"

$Inventory |
Export-Csv `
-NoTypeInformation `
-Path $OutputFile

Write-Host ""
Write-Host "Discovery Completed"
Write-Host ""

Write-Host "Groups Discovered :" $Inventory.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

$Inventory |
Select-Object -First 10 |
Format-Table
