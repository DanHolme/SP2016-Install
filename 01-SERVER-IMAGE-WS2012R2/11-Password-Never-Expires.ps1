# SET PASSWORD TO NEVER EXPIRE
# 1.0
# 17 March 2016
#
# (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
# FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
# Please provide feedback to Dan Holme
# dan.holme@intelliem.com
# Follow Dan Holme and the SharePoint Installation Scripts on GitHub
# https://github.com/DanHolme/SP2016-Install
#
# This script configures a user's account flag
# PASSWORD NEVER EXPIRES
#
# Used in a demo environment, this ensures that the
# local Administrator password does not expire
#
# REQUIREMENTS: Execute as a local administrator 
#
# TESTED ON: Windows Server 2012 R2 servers.
#
# VERSION HISTORY
# 1.0      THIS VERSION

# -------------------
# CONFIGURATION BLOCK

# Password Never Expires
$UserName = $env:USERNAME

# CONFIGURATION BLOCK
# -------------------

Write-Host "Setting password never expires for: $UserName"
$User = gwmi win32_USERACCOUNT | Where-Object {$_.NAME -eq $username}
$User.PasswordExpires = $False
$Result = $User.Put()

Write-Host
Write-Host "Complete"