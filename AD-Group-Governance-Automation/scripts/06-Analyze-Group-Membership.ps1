<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 06-Analyze-Group-Membership.ps1

Purpose :
Analyzes group memberships and classifies groups based on
membership size.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Group Membership Analysis Engine"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$InputFile = Join-Path $PSScriptRoot "..\reports\discovered-groups.csv"

$OutputFolder = Join-Path $PSScriptRoot "..\reports"

$OutputFile = Join-Path $OutputFolder "membership-analysis.csv"

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
# Analyze
#---------------------------------------------------

foreach($Group in $Groups)
{

    $Count = [int]$Group.MemberCount

    if($Count -eq 0)
    {
        $Category = "Empty Group"
        $Risk = "HIGH"
    }
    elseif($Count -le 5)
    {
        $Category = "Very Small"
        $Risk = "MEDIUM"
    }
    elseif($Count -le 50)
    {
        $Category = "Normal"
        $Risk = "LOW"
    }
    elseif($Count -le 200)
    {
        $Category = "Large"
        $Risk = "LOW"
    }
    else
    {
        $Category = "Very Large"
        $Risk = "MEDIUM"
    }

    $Results += [PSCustomObject]@{

        GroupID = $Group.GroupID

        GroupName = $Group.GroupName

        MemberCount = $Count

        MembershipCategory = $Category

        MembershipRisk = $Risk

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
Write-Host "Membership Analysis Completed"
Write-Host ""

Write-Host "Groups Processed :" $Results.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

$Results |
Select-Object -First 10 |
Format-Table
