<#.SYNOPSIS

This script will test connectivity and then compare the DISA GPO archive on the public site 
to the archive in the root folder.  If not the same based on name, it will automate the download
and unpackaging of the archive to the script folder.
If it is the same name the included package, it will forgo downloading and unpackage the archive 
included in root folder.

If the option to run this script is selected (in intiator script),
and there is no internet connectivity, it will continue with the unpackaging of the archive folder.  

.DESCRIPTION
Bill VaughnTool to automate and unpackage the DoD GPOs provided on the Public Disa Site.Check for connectivity if true, check if we have current DISA PUBLIC GPOs if not currentdownload new GPO archive from disa site and unpackage.#>$name = Get-ChildItem -Path $rootDir -Filter "*U_STIG*"$Conn_Test = Test-Connection -Quiet 8.8.8.8 -ErrorAction SilentlyContinueif($Conn_Test -eq $true){$WebResponse = Invoke-WebRequest https://public.cyber.mil/stigs/gpo/$checkName = $DisaDownloadLink -split '/'|select -Last 1 $fileExists = Test-Path $rootDir\$checkNameif($fileExists -ne $true){$checkName = $WebResponse.BaseResponse.ResponseUri -split '/'|select -Last 1 echo $checkName


$DisaDownloadLink = (($WebResponse.Links | Where-Object {$_.href -like "http*"} |
where outerHTML -ilike "*stig*").href | Select-String U_STIG_GPO | Out-String).Trim()
$x=Invoke-WebRequest -Uri $DisaDownloadLink -PassThru -OutFile ..\BV.tmp
$name=$x.BaseResponse.ResponseUri -split '/'|select -Last 1

Move-Item $rootDir\BV.tmp $rootDir\$name
Expand-Archive -Path $rootDir\$name -DestinationPath $scriptRoot\

Write-Host "
#################################################################################

The file" $name "did not exist. Successfully downloaded and unzipped $name"



} else{

Expand-Archive -Path $rootDir\$name -DestinationPath $scriptRoot\
Write-Host "
####################################

Successfully Unzipped $name"


}

}

else{
clear

write-host "

#############################################################################################################

It appears you do not have internet, please validate that the GPOs in the source folder are the most current.
They can be found at https://public.cyber.mil/stigs/gpo.

Move them into this folder, delete old archive, rerun, and then press enter. 

If you press enter the current GPOs in the folder will be unpackeged.

##############################################################################################################
" 
Write-Host "
Press enter to Continue:
"
$uselessVar = Read-Host

clear;

$name = Get-ChildItem -Path $rootDir -Filter "*U_STIG*"

Expand-Archive -Path $rootDir\$name -DestinationPath $scriptRoot\ iErrorAction SilentlyContinue

Write-Host "
####################################
Successfully Unzipped $name "

}

