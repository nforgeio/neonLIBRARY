﻿# neonKUBE Developer Setup

This page describes how to get started with neonLIBRARY development.

## Workstation Requirements

* Windows 10 Professional (64-bit) with at least 16GB RAM
* Virtualization capable workstation
* Visual Studio 2019 Edition (or better)
* Visual Studio Code

Note that the build environment currently assumes that only one Windows user will be acting as a developer on any given workstation.  Developers cannot share a machine and neonLIBRARY only builds on Windows at this time.

## Workstation Configuration

Follow the steps below to configure a development or test workstation:

1. Make sure that Windows is **fully updated**.

2. We highly recommend that you configure Windows to display hidden files:

    * Press the **Windows key** and run **File Explorer**
    * Click the **View** tab at the top.
    * Click the **Options** icon on the right and select **Change folder and search options**.
    * Click the **View** tab in the popup dialog.
    * Select the **Show hidden files, folders, and drives** radio button.
    * Uncheck the **Hide extensions for known types** check box.

3. Some versions of Skype listen for inbound connections on ports **80** and **443**.  This will interfere with services we'll want to test locally.  You need to disable this:

    * In Skype, select the **Tools/Options** menu.
    * Select the **Advanced/Connection** tab on the left.
    * **Uncheck**: Use **port 80 and 443** for additional incoming connections.

      ![Skype Connections](Images/Developer/SkypeConnections.png?raw=true)
    * **Restart Skype**

4. Ensure that Hyper-V is installed and enabled:

    * Run the following command in a **cmd** window to verify that your workstation is capable of virtualization and that it's enabled. You're looking for output like the image below:
      ```
      systeminfo
      ```
      ![Virtualization Info](Images/Developer/virtualization.png?raw=true)

      looking for a message saying that: **A hypervisor has been detected.**

    * Press the Windows key and enter: **windows features** and press ENTER.

    * Ensure that the check boxes highlighted in red below are checked:

    ![Hyper-V Features](Images/Developer/hyper-v.png?raw=true) 

    * Reboot your machine as required.

5. Install the latest **32-bit** production release of PowerShell 7 from [here](https://github.com/PowerShell/PowerShell/releases) (`PowerShell-#.#.#-win.x86.msi`)

6. Enable PowerShell script execution via (in a CMD window as administrator):
    ```
    powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
    ```

7. Install **Visual Studio 2019 Community 16.9+** from [here](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=16)

  * Select **all workloads** on the first panel
  * Click **Individual components**, type *Git* in the search box and select **Git for Windows** and **GitHub extension for Visual Studio**
  * Click **Install** (and take a coffee break)
  * Apply any pending **Visual Studio updates**
  * **Close** Visual Studio to install any updates
  * **NOTE:** You need sign into Visual Studio using the **devops@neonforge.com**.  The password for this can be found at 1Password at **user-devops/NEONFORGE_LOGIN**

8. Create a **shortcut** for Visual Studio and configure it to run as **administrator**.  To build and run neonLIBRARY applications and services, **Visual Studio must be running with elevated privileges**.

9. Install some SDKs:
   * Install .NET Core SDK v3.1.403 from [here](https://dotnet.microsoft.com/download/dotnet-core/3.1)
   * Install **.NET Framework 4.8 Developer Pack** from [here](https://dotnet.microsoft.com/download/thank-you/net48-developer-pack)

10. Install **Docker for Windows (Stable)** from [here](http://hub.docker.com)

    * You'll need to create a DockerHub account if you don't already have one.

11. **Clone** the [https://github.com/nforgeio/neonLIBRARY](https://github.com/nforgeio/neonLIBRARY) repository to your workstation:

    * **IMPORTANT:** All neonFORGE related repositories must be cloned within the same parent directory and their folder names cannot be changed.
    * Create an individual GitHub account [here](https://github.com/join?source=header-home) if you don't already have one
    * Go to [GitHub](http://github.com) and log into your account
    * Go to the neonLIBRARY [repository](https://github.com/nforgeio/neonLIBRARY).
    * Click the *green* **Code** button and select **Open in Visual Studio**
    * A *Launch Application* dialog will appear.  Select **Microsoft Visual Studio Protocol Handler Selector** and click **Open Link**
    * Choose or enter the directory where the repository will be cloned.  This defaults to a user specific folder.  I typically change this to a global folder (like **C:\src**) to keep the file paths short.
    * Click **Clone**

12. Disable **Python Import Warnings** via **Tools/Options: by unchecking this**

   ![System Tray](Images/Developer/PythonImports.png?raw=true)
  
13. Configure the build **environment variables**:

    * Open **File Explorer**
    * Navigate to the directory holding the cloned repository
    * **Right-click** on **buildenv.cmd** and then **Run as adminstrator**
    * Press ENTER to close the CMD window when the script is finished
  
14. **Clone** the other neonFORGE repos to the same directory as **neonLIBRARY** without changing their folder names:

    * [https://github.com/nforgeio/temporal-samples](https://github.com/nforgeio/temporal-samples)
    * [https://github.com/nforgeio/cadence-samples](https://github.com/nforgeio/cadence-samples)
    * [https://github.com/nforgeio/nforgeio.github.io](https://github.com/nforgeio/nforgeio.github.io)

    You can do this manually or use the CMD script below: 

    ```
    cd "%NF_ROOT%\.."
    mkdir nforgeio.github.io
    git clone https://github.com/nforgeio/nforgeio.github.io.git

    cd "%NF_ROOT%\.."
    mkdir cadence-samples
    git clone https://github.com/nforgeio/cadence-samples.git

    cd "%NF_ROOT%\.."
    mkdir temporal-samples
    git clone https://github.com/nforgeio/temporal-samples.git
    ```

15. **Close** any running instances of **Visual Studio**

16. Install **7-Zip (32-bit)** (using the Windows *.msi* installer) from [here](http://www.7-zip.org/download.html)

17. Install **Cygwin - setup-x86-64.exe** (all packages and default path) from: [here](https://www.cygwin.com/setup-x86_64.exe)

18. Many server components are deployed to Linux, so you’ll need terminal and file management programs.  We’re currently standardizing on **PuTTY** for the terminal and **WinSCP** for file transfer. install both programs to their default directories:

    * Install **WinSCP** from [here](http://winscp.net/eng/download.php) (I typically use the "Explorer" interface)
    * Install **PuTTY** from [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
    * *Optional*: The default PuTTY color scheme sucks (dark blue on a black background doesn’t work for me).  You can update the default scheme to Zenburn Light by **right-clicking** on the `$\External\zenburn-ligh-putty.reg` in **Windows Explorer** and selecting **Merge**
    * WinSCP: Enable **hidden files**.  Start **WinSCP**, select **View/Preferences...**, and then click **Panels** on the left and check **Show hidden files**:
    
      ![WinSCP Hidden Files](Images/Developer/WinSCPHiddenFiles.png?raw=true)

20. Install Visual Studio Code and GO (needed for the Cadence and Temporal proxy builds):
    * Install **Visual Studio Code** from [here](https://code.visualstudio.com/download)
    * Install **go1.13.windows-amd64.msi** or later for Windows from: [here](https://golang.org/dl/)

21. Confirm that the solution builds:

    * Restart **Visual Studio** as **administrator** (to pick up the new environment variables)
    * Open **$/neonLIBRARY.sln** (where **$** is the repo root directory)
    * Select **Build/Rebuild** Solution

22. *Optional*: Install **Notepad++** from [here](https://notepad-plus-plus.org/download)

23. *Optional*: Install **Postman** REST API tool from [here](https://www.getpostman.com/postman)

24. *Optional*: Install **Cmdr/Mini** command shell:

  * **IMPORTANT: Don't install the Full version** to avoid installing Linux command line tools that might conflict with the Cygwin tools installed earlier.
  * Download the ZIP archive from: [here](http://cmder.net/)
  * Unzip it into a new folder and then ensure that this folder is in your **PATH**.
  * Create a desktop shortcut if you wish and configure it to run as administrator.
  * Consider removing the alias definitions in `$\vendor\user_aliases.cmd.default` file so that commands like `ls` will work properly.  I deleted all lines beneath the first `@echo off`.
  * Run Cmdr to complete the installation.

25. *Optional*: Install the latest version of **XCP-ng Center** from [here](https://github.com/xcp-ng/xenadmin/releases) if you'll need to manage Virtual Machines hosted on XCP-ng.

26. *Optional*: Maintainers who will be publishing releases will need to:

    * **Download:** the latest recommended (at least **v5.8.0**) **nuget.exe** from [here](https://www.nuget.org/downloads) and put this somewhere in your `PATH`
    * Obtain a nuget API key from a maintainer and install the key on your workstation via:
	
	  `nuget SetApiKey YOUR-KEY`
	
    * **Install:** GitHub CLI (amd64) v1.4.0 or greater from: https://github.com/cli/cli/releases
    * **Close:** all Visual Studio instances.
    * **Install:** the HTML Help Compiler by running `$/External/htmlhelp.exe` with the default options.  You can ignore any message about a newer version already being installed.
    * **Unzip:** `$/External/SHFBInstaller_v2020.3.6.0.zip` to a temporary folder and run `SandcastleInstaller.exe`, then:
      * Click **Next** until you get to the **Sandcastle Help File Builder and Tools** page.
      * Click **Install SHFB**
	  * Click **Next** to the **Sandcastle Help File Builder Visual Studio Package** page.
	  * Click **Install Package**
	  * Click **Next**
	  * Click **Install Schemas**
      * Click **Next** until you get to the last page.
      * Click **Close** to close the SHFB installer.

27. *Optional*: Create the **EDITOR** environment variable and point it to `C:\Program Files\Notepad++\notepad++.exe` or your favorite text editor executable.

28. *Optional*: Maintainers will need to install then **GitHub CLI** from here: https://cli.github.com/

29: *Optional:* Maintainers will need to **AWS client version 2** from: [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-windows.html)

30: *Optional:* Maintainers authorized to perform releases will need to follow the README.md instructions in the neonCLOUD repo to configure credentials for the GitHub Releases and the Container Registry.
