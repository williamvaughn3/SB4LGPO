# SB4LGPO

Notes are brief and incomplete still. It's pretty late and I have been plugging away for about a week trying to get this finished.

# Test of Win10 non domain joined VM was functional - with all settings and applications.  
# Included the log file of the 347,000+ lines in the script root folder.

# On my Windows VM, 2Gb ram, 2Proc. It took 30ish minutes to apply all the settings.

<# Once the GpoMappingGuid.ps1 creates the necessary .ps1 files in the temp dir .ps1 file any GPOs you do not want applied.  They will be under the "collections" file
that is imported in the install-baseline file when you select your system type via menu.  Maybe in the future, a interactive comment will be introduced, however this
was a side project.  I need to get back to studying once I test a little more.  #>

<# Still needs a lot of work and cleanup.

Haven't tested the other system types at this time, will do in the future.

Near future, going to create the backup GPO for the registry and setting modifications that point the system updates to the DISA WSUS server.
Not the forum to have this discussion, but there are specific systems that I have in mind benifiting from this.  

If you have access to these files where I am posting, you're either a Warrant Officer,
or Jason.  You have my contact info and I highly value your opinion.  There are undoubtedly many mistakes, and issues, please let me know how to improve. #>

#Appreciate the support from the community.  You guys rock!

#Share freely.
