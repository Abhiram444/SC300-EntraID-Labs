<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 08-Generate-Governance-Report.ps1

Purpose :
Generates an executive governance report summarizing
group risk across the enterprise.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Enterprise Governance Report"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$InputFile = Join-Path $PSScriptRoot "..\reports\group-risk-score.csv"

$ReportsFolder = Join-Path $PSScriptRoot "..\reports"

$OutputFile = Join-Path $ReportsFolder "governance-report.csv"

#---------------------------------------------------
# Validation
#---------------------------------------------------

if(!(Test-Path $InputFile))
{
    Write-Host "ERROR: group-risk-score.csv not found."
    exit
}

#---------------------------------------------------
# Import
#---------------------------------------------------

$Groups = Import-Csv $InputFile

#---------------------------------------------------
# Summary Metrics
#---------------------------------------------------

$TotalGroups = $Groups.Count

$HighRisk = ($Groups | Where-Object {$_.RiskLevel -eq "HIGH"}).Count

$MediumRisk = ($Groups | Where-Object {$_.RiskLevel -eq "MEDIUM"}).Count

$LowRisk = ($Groups | Where-Object {$_.RiskLevel -eq "LOW"}).Count

#---------------------------------------------------
# Export Detailed Report
#---------------------------------------------------

$Groups |
Sort-Object RiskScore -Descending |
Export-Csv `
-NoTypeInformation `
-Path $OutputFile

#---------------------------------------------------
# Executive Summary
#---------------------------------------------------

Write-Host ""
Write-Host "====================================="
Write-Host "EXECUTIVE SUMMARY"
Write-Host "====================================="
Write-Host ""

Write-Host "Total Groups        :" $TotalGroups
Write-Host "High Risk Groups    :" $HighRisk
Write-Host "Medium Risk Groups  :" $MediumRisk
Write-Host "Low Risk Groups     :" $LowRisk

Write-Host ""
Write-Host "Top 10 Highest Risk Groups"
Write-Host ""

$Groups |
Sort-Object RiskScore -Descending |
Select-Object `
GroupName,
RiskScore,
RiskLevel,
OwnershipStatus,
MembershipCategory `
-First 10 |
Format-Table -AutoSize

Write-Host ""
Write-Host "Detailed report exported to:"
Write-Host $OutputFile
