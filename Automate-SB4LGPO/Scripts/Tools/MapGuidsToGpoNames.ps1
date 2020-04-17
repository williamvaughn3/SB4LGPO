<#
.SYNOPSIS
Modified from the original script, this script will map GUIDs in the GPO backups provided
on the DISA Public site to GPO display names, and export to the temp dir, create the 
sorted list psobject, or write the names to the screen by parsing through the backup.xml files
 included in the GPOs and extracting the GUID and GPO name.
User Input to create the objects exist mainly for allowing for troubleshooting during creation. While
having the added benifit (or drawback) of not requiring params to be included in the execution.  
This script is designed to be ran sequentially. The option to run an automated download new of GPOs 
from the disa public site will be optionally completed first.

If download check is not chosen, and the unpackaged dir doesn't exist. The script will 
unpackage the archive in the root folder and map GPOs to GUIDs from the unpackaged file, and write
to the temp dir. The DISA GPOs  in the root folder are currently the Feburary 2020 package. 


.DESCRIPTION
A GPO backup is written to a directory named with a newly-generated GUID. The GPO's display name is embedded in a "backup.xml" file in that directory.
This script maps display names to GUIDs and outputs them as a sorted list or as formatted text.


The mapping will look similiar to this.
----                                                                       -----
DoD Access 2013 STIG User v1r6                                   {6029E4E2-8030-4803-B0F8-4EF1850B893B}
DoD Access 2016 STIG User v1r1                                   {A1410496-5F7D-4A87-A63E-E9198F50F57C}
DoD Adobe Acrobat Pro DC Classic STIG Computer v1r3              {C711BC12-4A88-4510-AF84-25CFF8CB852A}
DoD Adobe Acrobat Pro DC Classic STIG User v1r3                  {327F6565-415A-4160-AC3E-FED5831F74C8}
DoD Adobe Acrobat Pro DC Continuous STIG Computer V1R2           {0E3DF88D-8C94-4218-8C10-CC56255DFC5B}
DoD Adobe Acrobat Pro DC Continuous STIG User V1R2               {19D0D11E-5BCF-4F84-9C3F-7C92A29136B2}
DoD Excel 2013 STIG User v1r7                                    {2DB65096-FFEB-42DD-B77E-5CFBCDCFEC80}
DoD Excel 2016 STIG User v1r2                                    {58865187-147C-4666-9D40-A09859679965}
DoD Google Chrome STIG Computer v1r18                            {E56352ED-A083-401D-A260-AFC1710B0863}
DoD Infopath 2013 STIG Computer v1r5                             {8DC10A82-F7BA-4F5F-872A-64249E3EF1CA}
DoD Infopath 2013 STIG User v1r5                                 {05C35397-8CC1-4F83-8482-F34841B95A60}
DoD Internet Explorer 11 STIG Computer v1r18                     {973EA10F-4831-4A4B-A4AF-063D3B60B5D9}
DoD Internet Explorer 11 STIG User v1r18                         {DB70FD04-AD22-445F-9140-8034AFD605D5}
DoD Lync 2013 STIG Computer v1r4                                 {C9B064E7-0D8B-4B4E-8821-3D3C032C3EC8}
DoD Office System 2013 STIG Computer v1r9                        {298ABF06-47DB-4C27-9787-95549980A2E4}
DoD Office System 2013 STIG User v1r9                            {2366EAFE-3C98-4736-B316-E9B3A1E7F564}
DoD Office System 2016 STIG Computer v1r1                        {327D0A70-D6FF-46CF-93CE-361DA82FCFAC}
DoD Office System 2016 STIG User v1r1                            {0794D251-5F3E-4913-AB8D-B4CFD9C543B5}
DoD OneDrive for Business 2016 STIG Computer v1r2                {9CF0656F-9819-4B6C-87B6-BA15B98F1B79}
DoD OneDrive for Business 2016 STIG User v1r2                    {1431CD63-9DE5-48D4-B32D-72FF9B63FB26}
DoD Outlook 2013 STIG User v1r13                                 {5BE15BF4-5068-473F-BDD5-EEB6CCC5AB3E}
DoD Outlook 2016 STIG User v1r2                                  {17F8A73A-748C-4BEC-BADD-F584F10B65F7}
DoD PowerPoint 2013 STIG User v1r6                               {3A9BFA08-7548-4BB0-9CC4-4D1FC28F66A1}
DoD PowerPoint 2016 STIG User v1r1                               {A31233CC-EE3A-4DBD-92A0-E5BA5B64E270}
DoD Project 2013 STIG User v1r4                                  {0A032FAB-D65A-43B6-9BDF-D90E5DD60056}
DoD Project 2016 STIG User v1r1                                  {C85FD25F-5A9A-4F94-BCBD-E556DE9BB38B}
DoD Publisher 2013 STIG User v1r5                                {1F25599B-2D13-47FE-A760-26CA7DB31246}
DoD Publisher 2016 STIG User v1r3                                {68AFFE58-8FED-4CC3-B0EC-4886AED6012B}
DoD Skype for Business 2016 STIG Computer v1r1                   {2F8115A1-61B9-4FA8-9E96-7B555A879D4D}
DoD Visio 2013 STIG User v1r4                                    {DCC8A1CB-5C4E-48F7-83F3-12DC19494768}
DoD Visio 2016 STIG User v1r1                                    {D7568B34-94BB-4193-B2A9-2DDB7870BDB4}
DoD Windows 10 STIG Computer v1r20                               {FAC324FE-50EA-4923-9EAB-15049AC6D9C8}
DoD Windows 10 STIG User v1r20                                   {08283A27-9444-46F1-BFC5-3705478EC878}
DoD Windows 8 and 8.1 STIG Computer v1r21                        {C90F20B6-3C33-413F-AF81-50EE47D18F6C}
DoD Windows 8 and 8.1 STIG User v1r21                            {3676F25C-F4ED-4F82-9608-FA3D2F2A7029}
DoD Windows Defender Antivirus STIG Computer v1r7                {B173185B-7E53-46E2-A494-D6299E6DEA8A}
DoD Windows Firewall STIG v1r7                                   {7D8A0DA4-EC1B-4685-93EF-A080AD5F7D63}
DoD Windows Server 2012 R2 Domain Controller STIG Computer v2r19 {9B5B9CF4-B2F8-4CFC-8258-9384F6F1F659}
DoD Windows Server 2012 R2 Domain Controller STIG User v2r19     {3E503775-1D2B-4D55-98D7-B88916D899D5}
DoD Windows Server 2012 R2 Member Server STIG Computer v2r17     {C946DBC3-FD2D-4761-99A9-8124B822C59B}
DoD Windows Server 2012 R2 Member Server STIG User v2r17         {3CED5E25-34B8-465F-B953-F512141A0A1D}
DoD Windows Server 2016 Domain Controller STIG Computer v1r10    {2D9AE946-FA5B-4563-AFA0-152BB29F0E39}
DoD Windows Server 2016 Member Server STIG Computer v1r10        {B91E6980-EF32-4717-B025-EF5EA106CA49}
DoD Windows Server 2019 Domain Controller STIG Computer v1r3     {C07F9F2C-B32F-4A04-8F3C-3B4CB9AF8DCD}
DoD Windows Server 2019 Member Server STIG Computer v1r3         {A3F845B1-1E6B-4F74-9259-57335B91189D}
DoD Word 2013 STIG User v1r6                                     {3A49130C-0BF5-453B-837B-2BC538C55831}
DoD Word 2016 STIG User v1r1                                     {6B74C4EF-57F4-4A30-8EAB-2AF5D1AEEA60}
#>

<#
Commenting out Parameters since no longer neede
#####

param(
    [parameter(Mandatory=$true)]
    [String]
    $rootdir,

    [switch]
    $formatOutput
    )

########>

<#Check to see if the tempDir Exists, create if not
#>



Function tempDirSetup($scriptDir){
cd $scriptRoot
$tempExist = Test-Path "$scriptDir\temp" 
if($tempExist -eq $False){
cd $scriptRoot
New-Item -ItemType Directory -Force -Path .\temp\
cd .\temp\
$tempDir = pwd 
cd $scriptRoot
return $tempDir
}
cd .\temp\
$tempDir = pwd 
cd $scriptRoot
return $tempDir
}
$tempDir = tempDirSetup($scriptDir)

$results = New-Object System.Collections.SortedList
<#Check if GPO_Download Script executed and the archive is already unpackaged, do so if not.
#>
Function GPODir($scriptDir){
cd $scriptDir
$GPOsExist = Test-Path "*DISA STIG GPO*"

if($GPOsExist -eq $true){
$GPOFolderName = Get-ChildItem -Path $scriptDir -Filter "*DISA STIG GPO*" | %{$_.fullname}
write-host "GPO Folder Name:" $GPOFolderName
cd $scriptRoot
Return $GPOFolderName
}

$name = Get-ChildItem -Path $rootDir -Filter "*U_STIG*"
Expand-Archive $rootDir\$name -DestinationPath $scriptDir\ 
$GPOFolderName = Get-ChildItem -Path $scriptDir -Filter "*DISA STIG GPO*" | %{$_.fullname}
cd $scriptRoot
Return $GPOFolderName
}

Function CreateGPOMapping($GPOFolder){


###########################################################

Get-ChildItem -Recurse -Include backup.xml $GPOFolder | ForEach-Object {
    
    $guid = $_.Directory.Name
    $displayName = ([xml](gc $_)).GroupPolicyBackupScheme.GroupPolicyObject.GroupPolicyCoreSettings.DisplayName.InnerText
    $results.Add($displayName, $guid)
    }
    return $results
}



Do {
Clear
Write-Host "

____________Map Disa GUIDs to GPO Names____________"
Write-Host "Please select an option from the choices below.

1. ", "Create the GPO to GUID mapping files <----Most likely want to choose this
" -ForeGroundColor Yellow
Write-Host "2. ", "Create SortedList Object in memory
" -ForeGroundColor Yellow
Write-Host "3. ", "Output the Guid Mapping to Screen
" -ForeGroundColor Yellow
Write-host "Q. ", "Quit without doing anything." -ForeGroundColor Yellow

Write-host "_______________________________________________"
Write-host "
Info:
1-Create The Mapping files needed for installation, they will be stored in the temp dir.
2-Create SortedList Object in memory, useful if you're going to manipulate the object. (advanced)
3-See the Table on Screen
" -ForeGroundColor Green

$choice1 = read-host -prompt "Select number & press enter"
} until ($choice1 -eq "1" -or $choice1 -eq "2" -or $choice1 -eq "3" -or $choice1 -eq "Q" -or $choice1 -eq "q")

Switch ($choice1) {
"1" {
$tempDir = tempDirSetup($scriptDir)
$GPOFolder = GPODir($scriptDir)
$results = CreateGPOMapping($GPOFolder)
$results.GetEnumerator() | Sort-Object Name | Export-CliXml -path $tempDir\GPOGUIDmap.xml 
$results.GetEnumerator() | Sort-Object Name | Export-csv -path $tempDir\GPOGUIDmap.csv 

 }
     
"2" {
$tempDir = tempDirSetup($scriptDir)
$GPOFolder = GPODir($scriptDir)
$results = CreateGPOMapping($GPOFolder)
        }


"3" {
$tempDir = tempDirSetup($scriptDir)
$GPOFolder = GPODir($scriptDir)
$results = CreateGPOMapping($GPOFolder)
$results | Format-Table -AutoSize
Start-Sleep -Seconds 8
.\MapGuidsToGpoNames.ps1 
  }


"Q" {
clear
Write-Host "You selected quit. Exiting now..."
exit;exit;exit
return
}
}

. $ScriptDir\Baseline-LocalInstall.ps1