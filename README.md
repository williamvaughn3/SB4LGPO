17APR2020
Forgive formatting, being lazy right now. 

# SB4LGPO

# A/O 15APR Test of Win10 non domain joined VM was functional - All settings and applications were applied, including some unnecessary, but still wanted to test. (both full office ?13/16? suites, visio, skype, ect)

#Didn't focus on this for the last two days, and it still needs a lot of work and cleanup based on Nando's guidance.

# Included the log file of the 347,000+ lines in the script root folder of settings applied.

# On my Windows 10 pro VM, running only 2Gb ram, 2Proc. It took 30ish minutes to apply all the settings.

<#
  Once the GpoMappingGuid.ps1 creates the necessary .ps1 files in the temp dir .ps1 file any GPOs you do not want applied.  They will be   under the "collections" file that is imported in the install-baseline file when you select your system type via menu.  
    
      -Thinking maybe a good idea to do an lookup on the system, either via registry setting via clsids, cim or wmi to do a logic check of what applications exist, and parse for like GPOs.  Will need to further parse the GPOs in the application collections, and use that in an "app-check" function as an parameter to the AddToCollection Function.#>


<#Haven't tested the other system types at this time, but my take is that we are going to try to solve a single problem, instead of generalized functionality, it may be worth consideration of removing that functionality, and splitting this project into two purposes.  One for the problem Will has defined, and one for general any system function.#>

<#Will's suggestion of having only one system pull the ZIP from the DISA site needs to be implemented.   Thinking of creating a case selection asking for share path of zip or if first time...  Ref the email "other could be something is designed to be ran on a local system, but executed from a shared folder.IE: You run it from the remote system (or  local if you're sitting at it accessing the remote share), and it just copies all items to local directory, forgoes the external net check / download, and runs the sequence of scripts after archive is unzipped and copied to the local machine."
###Thoughts?#>

<#Still need to create the backup GPO for the registry and setting modifications that point the system updates to the DISA WSUS server.
Not the forum to have this discussion, but there are specific systems.  Would be great to find out the nuances of delivery optimization functionality in windows 10.  Which we could leverage to create an unmanaged, ghetto wsus server, which uses only one system to sync. A lot of unknowns, but one big one would be if we are not allowing them to communicate, download, how would they know the updates need pulled in the first place, does the delivery optimization do this?#>
