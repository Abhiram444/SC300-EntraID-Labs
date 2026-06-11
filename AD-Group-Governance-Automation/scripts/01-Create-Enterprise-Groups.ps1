<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 01-Create-Enterprise-Groups.ps1

Purpose :
Creates a realistic enterprise Active Directory group inventory.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Creating Enterprise Groups..."
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Configuration
#---------------------------------------------------

$TotalGroups = 500

$Departments = @(
"IT",
"Engineering",
"Security",
"Finance",
"HR",
"Sales",
"Marketing",
"Operations",
"Legal",
"CustomerSuccess"
)

$GroupTypes = @(
"Security",
"Distribution"
)

$Results = @()

#---------------------------------------------------
# Generate Groups
#---------------------------------------------------

for($i=1;$i -le $TotalGroups;$i++)
{

    $Department = Get-Random -InputObject $Departments

    $GroupType = Get-Random -InputObject $GroupTypes

    $GroupNumber = "{0:D4}" -f $i

    $Results += [PSCustomObject]@{

        GroupID = "GRP-$GroupNumber"

        GroupName = "GRP-$Department-$GroupNumber"

        Department = $Department

        GroupType = $GroupType

        Description = "$Department Department Group"

        Status = "Active"

    }

}

#---------------------------------------------------
# Export
#---------------------------------------------------

$OutputFolder = Join-Path $PSScriptRoot "..\data"

if(!(Test-Path $OutputFolder))
{
    New-Item `
    -ItemType Directory `
    -Path $OutputFolder | Out-Null
}

$OutputFile = Join-Path $OutputFolder "groups.csv"

$Results |
Export-Csv `
-Path $OutputFile `
-NoTypeInformation

Write-Host ""
Write-Host "==============================================="
Write-Host "Groups Created Successfully"
Write-Host "==============================================="
Write-Host ""

Write-Host "Total Groups :" $Results.Count
Write-Host "Output File  :" $OutputFile

Write-Host ""

Import-Csv $OutputFile |
Select-Object -First 10 |
Format-Table
