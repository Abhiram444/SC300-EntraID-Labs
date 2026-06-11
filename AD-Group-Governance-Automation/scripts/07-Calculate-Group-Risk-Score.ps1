<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 07-Calculate-Group-Risk-Score.ps1

Purpose :
Calculates a governance risk score for every group by combining
ownership and membership analysis.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Group Risk Scoring Engine"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$OwnershipFile = Join-Path $PSScriptRoot "..\reports\ownership-validation.csv"

$MembershipFile = Join-Path $PSScriptRoot "..\reports\membership-analysis.csv"

$OutputFolder = Join-Path $PSScriptRoot "..\reports"

$OutputFile = Join-Path $OutputFolder "group-risk-score.csv"

#---------------------------------------------------
# Validation
#---------------------------------------------------

if(!(Test-Path $OwnershipFile))
{
    Write-Host "ownership-validation.csv not found"
    exit
}

if(!(Test-Path $MembershipFile))
{
    Write-Host "membership-analysis.csv not found"
    exit
}

#---------------------------------------------------
# Import
#---------------------------------------------------

$Ownership = Import-Csv $OwnershipFile
$Membership = Import-Csv $MembershipFile

$Results = @()

#---------------------------------------------------
# Risk Calculation
#---------------------------------------------------

foreach($Group in $Ownership)
{

    $MembershipInfo = $Membership |
    Where-Object {$_.GroupID -eq $Group.GroupID}

    $Score = 0

    # Ownership Risk

    switch ($Group.OwnershipStatus)
    {
        "No Owner" {$Score += 50}

        "Multiple Owners" {$Score += 25}

        default {$Score += 0}
    }

    # Membership Risk

    switch ($MembershipInfo.MembershipCategory)
    {
        "Empty Group" {$Score += 40}

        "Very Small" {$Score += 15}

        "Normal" {$Score += 0}

        "Large" {$Score += 5}

        "Very Large" {$Score += 15}
    }

    if($Score -ge 50)
    {
        $Risk="HIGH"
    }
    elseif($Score -ge 20)
    {
        $Risk="MEDIUM"
    }
    else
    {
        $Risk="LOW"
    }

    $Results += [PSCustomObject]@{

        GroupID=$Group.GroupID

        GroupName=$Group.GroupName

        OwnershipStatus=$Group.OwnershipStatus

        MembershipCategory=$MembershipInfo.MembershipCategory

        RiskScore=$Score

        RiskLevel=$Risk

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

Write-Host "Risk Scoring Completed"

Write-Host ""

Write-Host "Groups Processed :" $Results.Count

Write-Host ""

Write-Host "Output File"

Write-Host $OutputFile

Write-Host ""

$Results |
Sort-Object RiskScore -Descending |
Select-Object -First 10 |
Format-Table
