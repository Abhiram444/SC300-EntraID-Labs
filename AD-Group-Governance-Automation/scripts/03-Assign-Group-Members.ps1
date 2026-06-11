<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 03-Assign-Group-Members.ps1

Purpose :
Assigns realistic memberships to enterprise groups.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Assigning Group Members..."
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$EmployeeFile = Join-Path $PSScriptRoot "..\data\employees.csv"

$GroupFile = Join-Path $PSScriptRoot "..\data\groups.csv"

$OutputFolder = Join-Path $PSScriptRoot "..\data"

$OutputFile = Join-Path $OutputFolder "memberships.csv"

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
# Assign Members
#---------------------------------------------------

foreach($Group in $Groups)
{

    $Scenario = Get-Random -Minimum 1 -Maximum 101

    if($Scenario -le 10)
    {
        $MemberCount = 0
    }
    elseif($Scenario -le 25)
    {
        $MemberCount = Get-Random -Minimum 1 -Maximum 6
    }
    elseif($Scenario -le 60)
    {
        $MemberCount = Get-Random -Minimum 10 -Maximum 51
    }
    elseif($Scenario -le 90)
    {
        $MemberCount = Get-Random -Minimum 50 -Maximum 201
    }
    else
    {
        $MemberCount = Get-Random -Minimum 200 -Maximum 501
    }

    if($MemberCount -eq 0)
    {
        continue
    }

    $Members = $Employees | Get-Random -Count $MemberCount

    foreach($Member in $Members)
    {

        $Results += [PSCustomObject]@{

            GroupID = $Group.GroupID

            GroupName = $Group.GroupName

            EmployeeID = $Member.EmployeeID

            EmployeeName = $Member.DisplayName

            Department = $Member.Department

        }

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

Write-Host "Membership Assignment Completed"

Write-Host ""

Write-Host "Groups Processed :" $Groups.Count

Write-Host "Membership Records :" $Results.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

Import-Csv $OutputFile |
Select-Object -First 10 |
Format-Table
