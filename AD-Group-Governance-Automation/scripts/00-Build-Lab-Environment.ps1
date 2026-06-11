<#
===========================================================================
Project : AD Group Governance Automation Suite

Script  : 00-Build-Lab-Environment.ps1

Purpose :
Build a realistic enterprise lab consisting of employees,
groups, owners and memberships.

Author  : Abhiram

Version : 1.0
===========================================================================
#>

Clear-Host

#----------------------------------------------------------
# Configuration
#----------------------------------------------------------

$Config = @{

    CompanyName = "Falcon Technologies Global"

    EmployeeCount = 1000

    GroupCount = 500

    OutputFolder = "..\data"

}

#----------------------------------------------------------
# Create Output Folder
#----------------------------------------------------------

if(!(Test-Path $Config.OutputFolder))
{
    New-Item `
    -ItemType Directory `
    -Path $Config.OutputFolder | Out-Null
}

#----------------------------------------------------------
# Enterprise Master Data
#----------------------------------------------------------

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
"Customer Success"

)

$Cities = @(

"Hyderabad",
"Bangalore",
"Pune",
"Chennai",
"Mumbai",
"Delhi"

)

$Titles = @(

"Analyst",
"Engineer",
"Senior Engineer",
"Lead Engineer",
"Administrator",
"Consultant",
"Manager",
"Senior Manager",
"Director"

)

$FirstNames = @(
"Aarav","Vivaan","Aditya","Arjun","Krishna",
"Rohan","Rahul","Priya","Ananya","Diya",
"Sneha","Ishita","Aisha","Neha","Kiran",
"Vikram","Ritika","Akash","Sanjay","Meera"
)

$LastNames = @(
"Sharma","Patel","Reddy","Gupta","Kumar",
"Nair","Iyer","Verma","Rao","Joshi",
"Kapoor","Singh","Das","Kulkarni","Menon"
)

#----------------------------------------------------------
# Generate Employees
#----------------------------------------------------------

$Employees = @()

for($i=1;$i -le $Config.EmployeeCount;$i++)
{

    $First = Get-Random $FirstNames

    $Last = Get-Random $LastNames

    $Department = Get-Random $Departments

    $City = Get-Random $Cities

    $Title = Get-Random $Titles

    $Employees += [PSCustomObject]@{

        EmployeeID = "EMP$('{0:D5}' -f $i)"

        FirstName = $First

        LastName = $Last

        DisplayName = "$First $Last"

        Department = $Department

        City = $City

        JobTitle = $Title

        Status = "Active"

    }

}

#----------------------------------------------------------
# Export Employees
#----------------------------------------------------------

$Employees |

Export-Csv `
"$($Config.OutputFolder)\employees.csv" `
-NoTypeInformation

Write-Host ""
Write-Host "====================================="
Write-Host "Enterprise Environment Initialized"
Write-Host "====================================="
Write-Host ""

Write-Host "Company   :" $Config.CompanyName
Write-Host "Employees :" $Employees.Count
Write-Host ""
