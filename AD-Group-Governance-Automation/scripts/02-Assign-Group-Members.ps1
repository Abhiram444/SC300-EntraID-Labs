<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 02-Assign-Group-Owners.ps1

Purpose :
Assigns owners to enterprise groups and intentionally creates
governance issues for testing.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Assigning Group Owners..."
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$EmployeeFile = Join-Path $PSScriptRoot "..\data\employees.csv"

$GroupFile = Join-Path $PSScriptRoot "..\data\groups.csv"

$OutputFolder = Join-Path $PSScriptRoot "..\data"

$OutputFile = Join-Path $OutputFolder "owners.csv"

#---------------------------------------------------
# Validation
#---------------------------------------------------

if(!(Test-Path $EmployeeFile))
{
    Write-Host "employees.csv not found"
    exit
}

if(!(Test-Path $GroupFile))
{
    Write-Host "groups.csv not found"
    exit
}

#---------------------------------------------------
# Import Data
#---------------------------------------------------

$Employees = Import-Csv $EmployeeFile

$Groups = Import-Csv $GroupFile

$Results = @()

#---------------------------------------------------
# Assign Owners
#---------------------------------------------------

foreach($Group in $Groups)
{

    $Scenario = Get-Random -Minimum 1 -Maximum 101

    #----------------------------
    # No Owner (8%)
    #----------------------------

    if($Scenario -le 8)
    {

        $Results += [PSCustomObject]@{

            GroupID = $Group.GroupID

            GroupName = $Group.GroupName

            OwnerID = ""

            OwnerName = ""

            OwnerType = "No Owner"

        }

        continue
    }

    #----------------------------
    # Multiple Owners (5%)
    #----------------------------

    if($Scenario -le 13)
    {

        $Owner1 = Get-Random $Employees

        $Owner2 = Get-Random $Employees

        $Results += [PSCustomObject]@{

            GroupID = $Group.GroupID

            GroupName = $Group.GroupName

            OwnerID = $Owner1.EmployeeID

            OwnerName = $Owner1.DisplayName

            OwnerType = "Primary"

        }

        $Results += [PSCustomObject]@{

            GroupID = $Group.GroupID

            GroupName = $Group.GroupName

            OwnerID = $Owner2.EmployeeID

            OwnerName = $Owner2.DisplayName

            OwnerType = "Secondary"

        }

        continue
    }

    #----------------------------
    # Single Owner
    #----------------------------

    $Owner = Get-Random $Employees

    $Results += [PSCustomObject]@{

        GroupID = $Group.GroupID

        GroupName = $Group.GroupName

        OwnerID = $Owner.EmployeeID

        OwnerName = $Owner.DisplayName

        OwnerType = "Primary"

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

Write-Host "Owner Assignment Completed"

Write-Host ""

Write-Host "Groups Processed :" $Groups.Count

Write-Host "Owner Records    :" $Results.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

Import-Csv $OutputFile |
Select-Object -First 10 |
Format-Table
