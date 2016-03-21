# SERVER IMAGE (Windows Server 2012 R2)

Deploy a baseline image by installing Windows Server 2012 R2 with out-of-box configuration. Make changes to the default configuration that you want to 
deploy to all new servers. Sysprep the machine, and use the resulting image to deploy servers in the environment.

The precise configuration of the virtual machine and of Windows Server 2012 will vary based on your environment and requirements. 
For purposes of illustration, I will share the configuration I use for my demo environments.

How you manage the *machines* will depend on whether you are using physical or virtual machines. 
For purposes of illustration, I will document the process using virtual machines in VMware Workstation 12.0.

## 1. Create a virtual machine

The VM used for the baseline image does not have to be heavily resourced. You are only going to install Windows Server 2012 R2--you won't actually *use* the server.

I therefore start with a virtual machine with 1 processor and 1 GB RAM, but there's no magic to those numbers. 
You will assign resources to the VMs used for servers in the environment later in the process.

1. Click **File** and then click **New Virtual Machine** or, on the **Home** tab, click **Create a New Virtual Machine**
The Welcome to the New Virtual Machine Wizard appears.
2. Click **Typical (recommended)** and then click **Next**.
3. On the **Guest Operating System Installation** page, click **I will install the operating system later** and then click **Next**.
4. On the **Select a Guest Operating System** page, click **Microsoft Windows**.
5. Click the **Version** list and then click **Windows Server 2012**.
6. Click **Next**.
7. On the **Name the Virtual Machine** page, in the **Virtual machine name** box, type an administrator-friendly name for the virtual machine, for example, **Windows Server 2012 R2 Baseline Image**.
8. In the **Location** box, type a path for the virtual machine files.
9. Click **Next**.
10. On the **Specify Disk Capacity** page, in the **Maximum disk size (GB)** box, enter **60.0**. 
11. Click **Store virtual disk as a single file**.
12. Click **Next**.
13. On the **Ready to Create Virtual Machine** page, click **Customize Hardware**.
14. In the **Device** list, click **Memory**.
15. In the **Memory** panel, in the **Memory for this virtual machine** box, type **1024**.
16. In the **Device** list, click **New CD/DVD**.
17. In the **Connection** panel, click **Use ISO image file**.
18. Click **Browse**.
19. Browse to and select the ISO image of the Windows Server 2012 R2 installation DVD, then click **Open**.
20. In the **Device** list, click **Network Adapter**.
21. In the **Network connection** panel, click **Bridged: Connected directly to the physical network**.
22. Click **Close** to close the Hardware window.
23. Click **Finish**.

## 2. Install Windows Server 2012 R2

There isn't really any rocket science here. Step through a standard installation of Windows Server 2012 R2. I choose to install a GUI rather than use Server Core for my demo environments.

## 3. Install baseline software and drivers including virtual machine drivers and tools

Install any drivers and software that you want to "bake in" to your Windows Server 2012 R2 image. For example, I install VMware Tools, which is a collection of drivers and services that 
enhance the functionality of virtual machines in VMware Workstation.

## 4. Configure tweaks to the baseline image

If there are changes you want to make to the out-of-box configuration of Windows Server 2012 R2 for all machines that will be deployed using your image, now is the time to do so. 
I make the following changes to the baseline image in my demo environments.

### To run server image scripts

1. Log on as Administrator to a default, out-of-box installation and configuration of Windows Server 2012 R2. 
2. View, customize, and run the following scripts:

- **Password-Never-Expires**: Sets the password of the current user (Administrator) to "never expires." Useful in demonstration and training environments. 
- **Remote-Desktop-Enable**: Enables remote desktop (RDP) connections to the server.
- **Server-Manager-Startup-Disable**: Prevents Windows' Server Manager from starting automatically at logon.
- **IEESC-Disable**: Disables Internet Explorer Enhanced Security Configuration (IE ESC) so that it is easier to browse from the server. Useful in demonstration and training environments.

## 5. Run SYSPREP to prepare the machine for imaging

Sysprep.exe is a utility that prepares a functioning server to be used as an image to deploy other servers. 
Sysprep "generalizes" the machine--it strips away elements that are machine specific, such as the Administrator password, IP address, regional settings, product key, and computer name of the machine. 
After running sysprep.exe, you will shut down the machine and capture an image of the "generic" server. You will then deploy one or more new servers with the image. 
When a new server starts for the first time, a mini-setup routine will run automatically. Devices on the server will be detected, drivers installed, 
and you will be prompted for the unique configuration of the new server: regional settings, prdouct key, Administrator password, etc.

### To run **Sysprep.ps1**
1. Close all open applications
2. Open Windows PowerShell (the console, not the ISE) with the Run As Administrator option. 
3. Navigate to the folder where the script is saved by using the CD command, just like the command prompt.
4. Run the script.

## 6. Capture an image of the machine

The method you use to capture an image of the machine depends on the virtual server software you use and the deployment tools at your disposal.

In the case of VMware Workstation, you can simply copy the virtual disk (.vmdk) file for the virtual machine.

As a best practice, I always create a snapshot of my VM to capture the sysprepped state of the machine before I capture or deploy the image.

## 7. Deploy a new machine with the image

Again, the method you use to deploy an image depends on your environment.

With most virtualization platforms, including VMware, you can create a new VM and attach the image as a virtual disk in the new VM.

Alternately, VMware Workstation allows you to "clone" a virtual machine. Cloning effectively combines steps 6 and 7. You end up with a new VM that uses the source VM's 
virtual disk as an image. There are two types of clones in VMware Workstation: full clones and linked clones.
 
If you create a "full clone", VMware does the work of copying the machine's virtual disk file and creating a new virtual machine with the cloned disk. 
There is no "linkage" to the source (baseline) VM--you could move the new VM or delete the baseline VM with no impact to the new VM.

If you create a "linked clone", the source virtual disk (.vmdk) is used as the baseline for the new virtual machine, and will be forever associated with the new VM. 
When the new virtual machine starts, it creates a "difference file" that contains changes to the disk. The two files together--the baseline "linked clone" source and the 
difference file of the new VM--are combined to create a virtual disk in the new VM. The result appears, in the new VM, as a single disk. However, you are able to save 
disk space on your VM host, because you are not duplicating the baseline disk--you're adding to it. 

A source or baseline VM can be used to create multiple linked clones. In my demo environment, I use the baseline Windows Server 2012 R2 VM as the basis for 
all the other VMs in the environment. I create linked clones for each of the actual servers in the demo environment. By doing so, I greatly conserve disk space 
on my VMware host, which is usually a laptop with limited disk space. 

Linked clones are useful in demo and evaluation environments where you want to conserve disk space on your virtual machine host. However, if multiple VMs share the same 
source disk, performance may be degraded, so in a production environment it is recommended to use full clones. You must also be careful if you choose move the VM that is the 
source for the linked VMs, as the linked VMs might lose their "baseline" virtual disk.