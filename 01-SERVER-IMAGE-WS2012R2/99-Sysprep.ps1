# RUN SYSPREP
# 1.0
# 20 March 2016
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
# Follow Dan Holme and the SharePoint Installation Scripts on GitHub
# https://github.com/DanHolme/SP2016-Install
#
# This script runs SYSPREP.EXE to prepare the machine for imaging
#
# REQUIREMENTS: Execute as a local administrator
#
# TESTED ON: Windows Server 2012 R2 
# Should work on Windows Server 2008 R2 and later
#
# VERSION HISTORY
# 1.0      THIS VERSION

# -------------------
# CONFIGURATION BLOCK

# Command to run
$Command = "c:\windows\system32\sysprep\sysprep.exe"
$ArgumentList = "/generalize /oobe /shutdown"

# CONFIGURATION BLOCK
# -------------------

Write-Host "Ready to run SYSPREP.EXE to prepare the machine for imaging."
Write-Host "This script should be run from a PowerShell console,"
Write-Host "NOT from the Windows PowerShell ISE. Launch the"
Write-Host "Windows PowerShell console with the Run As Asministrator option."
Write-Host
Write-Host "Sysprep.exe will run and the machine will shut down."
Write-Host "Close all other applications before continuing."
Write-Host
Write-Host "Press ENTER to confirm you are ready to run SYSPREP."
Read-Host
Write-Host "start $Command $ArgumentList"
Start-Process $Command -ArgumentList $ArgumentList

