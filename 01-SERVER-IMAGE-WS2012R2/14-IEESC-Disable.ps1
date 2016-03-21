# DISABLE IE ESC (INTERNET EXPLORER ENHANCED SECURITY CONFIGURATION)
# 1.0
# 21 October 2013
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
# Follow Dan Holme and the SharePoint Installation Scripts on GitHub
# https://github.com/DanHolme/SP2016-Install
#
# This script creates disables IEESC for users and administrators
#
# REQUIREMENTS: Execute as a local administrator
#
# TESTED ON: Windows Server 2008 R2, Windows Server 2012 R2 
# Should work on Windows Server 2008 R2 and later, or Windows 7 or later
#
# VERSION HISTORY
# 1.0      THIS VERSION

# -------------------

Write-Host "Disabling IE Enhanced Security Configuration (IE ESC)"

# Administrators
$Key = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $Key -Name "IsInstalled" -Value 0

# Users
$Key = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
Set-ItemProperty -Path $Key -Name "IsInstalled" -Value 0

# Apply
Stop-Process -Name Explorer

Write-Host
Write-Host "Complete"