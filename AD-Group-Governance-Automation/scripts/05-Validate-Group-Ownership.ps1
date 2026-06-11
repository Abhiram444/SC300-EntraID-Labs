<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 05-Validate-Group-Ownership.ps1

Purpose :
Validates ownership of enterprise groups and identifies
ownership governance issues.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Group Ownership Validation Engine"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$InputFile = Join-Path $PSScriptRoot "..\reports\discovered-groups.csv"

$ReportsFolder = Join-Path $PSScriptRoot "..\reports"

$OutputFile = Join-Path $ReportsFolder "ownership-validation.csv"

#---------------------------------------------------
# Validation
#---------------------------------------------------

if(!(Test-Path $InputFile))
{
    Write-Host "ERROR: discovered-groups.csv not found."
    exit
}

#---------------------------------------------------
# Import
#---------------------------------------------------

$Groups = Import-Csv $InputFile

$Results = @()

#---------------------------------------------------
# Validate
#---------------------------------------------------

foreach($Group in $Groups)
{

    if([int]$Group.OwnerCount -eq 0)
    {
        $Status="No Owner"
        $Risk="HIGH"
    }
    elseif([int]$Group.OwnerCount -eq 1)
    {
        $Status="Valid Owner"
        $Risk="LOW"
    }
    else
    {
        $Status="Multiple Owners"
        $Risk="MEDIUM"
    }

    $Results += [PSCustomObject]@{

        GroupID=$Group.GroupID

        GroupName=$Group.GroupName

        Department=$Group.Department

        OwnerCount=$Group.OwnerCount

        MemberCount=$Group.MemberCount

        OwnershipStatus=$Status

        OwnershipRisk=$Risk

    }

}

#---------------------------------------------------
# Export
#---------------------------------------------------

$Results |
Export-Csv `
-NoTypeInformation `
-Path $OutputFile

Write-Host ""
Write-Host "Ownership Validation Completed"
Write-Host ""

Write-Host "Groups Processed :" $Results.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

$Results |
Select-Object -First 10 |
Format-Table
