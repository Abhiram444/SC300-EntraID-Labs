<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 09-Export-Executive-Dashboard.ps1

Purpose :
Creates dashboard-ready datasets for Excel or Power BI.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

Write-Host ""
Write-Host "==============================================="
Write-Host "Executive Dashboard Export"
Write-Host "==============================================="
Write-Host ""

#---------------------------------------------------
# Paths
#---------------------------------------------------

$ReportsFolder = Join-Path $PSScriptRoot "..\reports"

$DashboardFolder = Join-Path $PSScriptRoot "..\dashboard"

if(!(Test-Path $DashboardFolder))
{
    New-Item `
    -ItemType Directory `
    -Path $DashboardFolder | Out-Null
}

$RiskFile = Join-Path $ReportsFolder "group-risk-score.csv"

if(!(Test-Path $RiskFile))
{
    Write-Host "ERROR: group-risk-score.csv not found."
    exit
}

#---------------------------------------------------
# Import
#---------------------------------------------------

$Groups = Import-Csv $RiskFile

#---------------------------------------------------
# KPI Calculation
#---------------------------------------------------

$TotalGroups = $Groups.Count

$HighRisk = ($Groups | Where-Object {$_.RiskLevel -eq "HIGH"}).Count

$MediumRisk = ($Groups | Where-Object {$_.RiskLevel -eq "MEDIUM"}).Count

$LowRisk = ($Groups | Where-Object {$_.RiskLevel -eq "LOW"}).Count

$KPIs = @()

$KPIs += [PSCustomObject]@{
    Metric="Total Groups"
    Value=$TotalGroups
}

$KPIs += [PSCustomObject]@{
    Metric="High Risk Groups"
    Value=$HighRisk
}

$KPIs += [PSCustomObject]@{
    Metric="Medium Risk Groups"
    Value=$MediumRisk
}

$KPIs += [PSCustomObject]@{
    Metric="Low Risk Groups"
    Value=$LowRisk
}

#---------------------------------------------------
# Export KPI File
#---------------------------------------------------

$KPIs |
Export-Csv `
-NoTypeInformation `
-Path (Join-Path $DashboardFolder "dashboard-kpis.csv")

#---------------------------------------------------
# Export Dashboard Summary
#---------------------------------------------------

$Groups |
Sort-Object RiskScore -Descending |
Export-Csv `
-NoTypeInformation `
-Path (Join-Path $DashboardFolder "dashboard-summary.csv")

#---------------------------------------------------
# Export Top High Risk Groups
#---------------------------------------------------

$Groups |
Sort-Object RiskScore -Descending |
Select-Object -First 20 |
Export-Csv `
-NoTypeInformation `
-Path (Join-Path $DashboardFolder "top-high-risk-groups.csv")

#---------------------------------------------------
# Console Output
#---------------------------------------------------

Write-Host ""
Write-Host "==============================================="
Write-Host "Dashboard Export Completed"
Write-Host "==============================================="
Write-Host ""

Write-Host "Total Groups       :" $TotalGroups
Write-Host "High Risk Groups   :" $HighRisk
Write-Host "Medium Risk Groups :" $MediumRisk
Write-Host "Low Risk Groups    :" $LowRisk

Write-Host ""

Write-Host "Dashboard files created in:"

Write-Host $DashboardFolder
