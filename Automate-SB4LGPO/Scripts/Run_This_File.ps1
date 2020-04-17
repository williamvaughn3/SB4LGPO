clear

Write-Host "
         !!!     This needs to be ran from an elevated powershell prompt     !!!
         !!!     with appropriate execution policies set                     !!!
         
         Use this at your own risk.  Idea was inspired the during the SANS 505 
         Couse, by Author Jason Fossen.  

         !!!                                                                 !!!
         
         "
sleep -s 4

<# Change if needed.
# scriptRoot and ScriptDir are redundant at this time
# Possibly thinking of creating this initiator calling script in root dir
#>
$scriptRoot = split-path -parent $MyInvocation.MyCommand.Path
$scriptDir = $scriptRoot
cd $scriptRoot
cd ..\
$rootDir = pwd
cd $scriptDir
$tempDir = "$scriptDir\temp"
$toolsDir = "$scriptDir\Tools"
$name = Get-ChildItem -Path $rootDir -Filter "*U_STIG*" 

<#jump to scriptDir (not needed att)
#Will be useful if we need to pop or push to dirs later
popd $ScriptDir 
 
#>

<# Todo - option to use zip that exists (feb 2020) without doing
#the internet check "&" DISA site .Zip scrape and compare.
#>
. $ScriptDir\GPO_install_run.ps1
. $toolsDir\MapGuidsToGpoNames.ps1
#Install initiated in MapGuid...ps1


