# ENABLE REMOTE DESKTOP
# 1.0
# 25 August 2015
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
# Follow Dan Holme and the SharePoint Installation Scripts on GitHub
# https://github.com/DanHolme/SP2016-Install
#
# This script enables remote desktop with secure connections
#
# REQUIREMENTS: Execute as a local administrator 
#
# TESTED ON: Windows Server 2012 R2 servers.
# Should work on Windows Server 2008 R2 and later
#
# VERSION HISTORY
# 1.0      THIS VERSION

# -------------------

# Enable remote desktop (do not deny connections)
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
$Value = (Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections").fDenyTSConnections
If ($Value -ne 0) { 
    Write-Host "Error configuring fDenyTSConnections registry value" 
    }
Else {
    Write-Host "Enabled remote desktop connections"
    }

# Require secure connections
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1 
$Value = (Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication").UserAuthentication
If ($Value -ne 1) { 
    Write-Host "Error configuring UserAuthentication registry value" 
    }
Else {
    Write-Host "Enabled secure connections for remote desktop"
    }

# Enable firewall rules to allow remote desktop connections
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Write-Host "Enabled Windows Firewall rules to allow remote desktop"
# Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Format-Table Name, Enabled -Autosize
Write-Host
Write-Host "Complete"