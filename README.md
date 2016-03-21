# SP2016-Install
PowerShell scripts you can use to install SharePoint Server 2016 in a lab or production environment.

These scripts can be used to install SharePoint Server 2016 in a lab or production environment. I use these scripts to install the servers I use for demos and evaluation with customers, and to deploy servers in customer farms.

## About the scripts

Scripts in this repository install servers for four roles. You may not require all roles in a production or lab environment. For a separate and isolated demo or lab, you will need all four roles, across 2-4 virtual (or physical) machines:

* Domain Controller
  * Hosts an Active Directory forest for the demo environment
* File Server
  * Hosts the files and scripts used to install SharePoint Server and SQL Server
  * Note I often install this role on my domain controller in a small demo or lab environment. The domain controller itself is not heavily burdened during installation, so it is fine to use it as the file server for installation.
* SQL Server
  * Hosts a SQL instance to support the SharePoint farm
  * I usually dedicate a separate VM for SQL Server in a demo or lab environment and always in a production environment.
* SharePoint Server
  * The scripts create a one- or two-server SharePoint farm, which is sufficient for demo, evaluation, and small production environments.

### Installation <> Configuration

The scripts create a SharePoint farm but do not configure it. I will upload the scripts I use to configure my demo environments at a later date. But these scripts get you from "bare metal" to the point where you can begin to configure the web and service applications in your farm.

### The approach to these scripts

These scripts are intentionally SIMPLE AND GRANULAR. I could have wrapped everything into functions and PowerShell cmdlets, error checking and logging, but then the scripts become unreadable. I wanted these scripts not only to do the job, but also to teach administrators exactly what is happening at each step in the process. By using scripts for each step, you can control each step, learn what is going on, and mix-and-match my scripts with other resources on the Internet as you see fit.

### Scripts <> Applications

I'm a big believer that the only criteria for success with administrative scripts is: did it work? Scripts do not have to be pretty, they don't have to be complex, they don't have to be reusable, object-oriented, capable of covering from every possible use case or recovering from every conceivable error. Scripts should not be measured with the same rulers used to judge an application. 

There are SharePoint farm installation tools in the community including [AutoSPInstaller] (https://autospinstaller.codeplex.com/) and for-fee deployment and configuration tools. I did not want these scripts to be a single solution for all scenarios, because doing so makes the scripts too complex for many admins to really understand, learn from, and adapt.  If you're looking for a tool that does it all for you, please look at those tools.

## Using the scripts

Scripts configure the farm in the following order:

- Domain Controller
- File Server
- SQL Server
- SharePoint Server

Follow the scripts in the order they are presented. Read the README files included in each folder.

For each script, open the script in the Windows PowerShell ISE or another editor (notepad.exe works, as well), and read the introductory comments at the top of the script. Most scripts have a block of variables that you should examine and configure according to your environment, so be sure to check each script for a section marked CONFIGURATION BLOCK. 

To run each script, open the Windows PowerShell ISE or a Windows PowerShell console with the RUN AS ADMINISTRATOR option. Many scripts will fail if you are not running the ISE/console with elevated credentials.  To make your life easier, I suggest you open the Windows PowerShell ISE with the Run As Administrator option. Then, you can open each script, explore it, modify it, run it, and repeat with the next script, all within a single application.
