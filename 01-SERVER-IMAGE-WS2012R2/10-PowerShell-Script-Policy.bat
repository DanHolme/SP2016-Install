:: SET POWERSHELL EXECUTIONPOLICY TO UNRESTRICTED SO SCRIPTS CAN RUN
:: 1.0
:: 17 March 2016
::
:: (c) Intellem, Inc. - DO NOT DISTRIBUTE WITHOUT PERMISSION.
:: FOR DEMONSTRATION PURPOSES ONLY. USE AT YOUR OWN RISK.
:: Please provide feedback to Dan Holme
:: dan.holme@intelliem.com
::
:: Follow Dan Holme and the SharePoint Installation Scripts on GitHub
:: https://github.com/DanHolme/SP2016-Install
::
:: This command sets the ExecutionPolicy for Windows PowerShell so that PowerShell scripts can be run successfully
::
:: REQUIREMENTS: Execute as a local administrator 
::
:: TESTED ON: Windows Server 2012 R2
::
:: VERSION HISTORY
:: 1.0      THIS VERSION
::
powershell.exe "Set-ExecutionPolicy Unrestricted" 