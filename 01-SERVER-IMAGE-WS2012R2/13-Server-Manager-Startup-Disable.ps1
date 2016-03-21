# DISABLE SERVER MANAGER STARTUP
# 1.0
# 17 MARCH 2016
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
# Follow Dan Holme and the SharePoint Installation Scripts on GitHub
# https://github.com/DanHolme/SP2016-Install
#
# This script prevents Server Manager from starting up
#
# REQUIREMENTS: Execute as a local administrator 
#
# TESTED ON: Windows Server 2012 R2 servers.
# Should work on Windows Server 2016
#
# VERSION HISTORY
# 1.0      THIS VERSION

# -------------------

# Disable Server Manager startup for all new logons
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager'-name "DoNotOpenServerManagerAtLogon" -Value 1
$Value = (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\ServerManager'-name "DoNotOpenServerManagerAtLogon").DoNotOpenServerManagerAtLogon
If ($Value -ne 1) { 
    Write-Host "Error configuring DoNotOpenServerManagerAtLogon registry value" 
    }
Else {
    Write-Host "Disabled Server Manager startup for all new logons"
    }

# Disable Server Manager startup for the current user
Set-ItemProperty -Path 'HKCU:Software\Microsoft\ServerManager' -name "CheckedUnattendLaunchSetting" -Value 0
$Value = (Get-ItemProperty -Path 'HKCU:Software\Microsoft\ServerManager' -name "CheckedUnattendLaunchSetting").CheckedUnattendLaunchSetting
If ($Value -ne 0) { 
    Write-Host "Error configuring CheckedUnattendLaunchSetting registry value" 
    }
Else {
    Write-Host "Disabled Server Manager startup for the current user"
    }

Write-Host
Write-Host "Complete"