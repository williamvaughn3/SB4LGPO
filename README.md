17APR2020

# SB4LGPO

# A/O 15APR Test of Win10 non domain joined VM was functional - All settings and applications were applied, including some unnecessary, but still wanted to test. (both full office ?13/16? suites, visio, skype, ect)

#Didn't focus on this for the last two days, and it still needs a lot of work and cleanup based on Nando's guidance.

# Included the log file of the 347,000+ lines in the script root folder of settings applied.

# On my Windows 10 pro VM, running only 2Gb ram, 2Proc. It took 30ish minutes to apply all the settings.

<#
  Once the GpoMappingGuid.ps1 creates the necessary .ps1 files in the temp dir .ps1 file any GPOs you do not want applied.  They will be   under the "collections" file that is imported in the install-baseline file when you select your system type via menu.  
    
      -Thinking maybe a good idea to do an lookup on the system, either via registry setting via clsids, cim or wmi to do a logic check        of what applications exist, and parse for like GPOs.  Will need to further parse the GPOs in the application collections, and use        that in an "app-check" function as an parameter to the AddToCollection Function.#>


#Haven't tested the other system types at this time, will do in the future.

#Still need to create the backup GPO for the registry and setting modifications that point the system updates to the DISA WSUS server.
Not the forum to have this discussion, but there are specific systems.  Would be great to find out the nuances of delivery optimization functionality in windows 10.  Which we could leverage to create an unmanaged, ghetto wsus server, which uses only one system to sync. A lot of unknowns, but one big one would be if we are not allowing them to communicate, download, how would they know the updates need pulled in the first place, does the delivery optimization do this?    

#Appreciate the assistance Nando, Will, and Luke!!!!  
