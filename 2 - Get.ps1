break

#################### What can I GET?

####################
#  WINDOWS EVENTS  #
####################

#GUI
eventvwr
#PowerShell v5.1 or lower
Get-EventLog -LogName Application -Newest 20


#####################
#  SCHEDULED TASKS  #
#####################

#GUI
taskschd
#PowerShell
Get-ScheduledTask | Select-Object -First 20


#####################
#   TASKS MANAGER   #
#####################

#GUI
taskmgr
#PowerShell
Get-Process | Select-Object -First 20


################
#   SERVICES   #
################

#GUI
taskmgr
#PowerShell
Get-Service | Select-Object -First 20


########################
#   NETWORK ADAPTERS   #
########################

#GUI
ncpa
#PowerShell
Get-NetAdapter


####################
#       FILES      #
####################

#GUI
Invoke-Item .
#PowerShell
Get-ChildItem


#######################
#       PRINTERS      #
#######################

#GUI
control printers
#PowerShell
Get-Printer



############################
#    INSTALLED PROGRAMS    #
############################

# Wiped and reloaded my PC 2 days ago. Woops
#GUI
appwiz
#PowerShell
Get-Package | Sort-Object ProviderName



#####################
#     TEXT FILES    #
#####################

#GUI
start .\Files\SampleData.csv
#PowerShell
Import-Csv -Path .\Files\SampleData.csv | Select-Object 'statecode','county','line','construction' -first 20


######################
#     EXCEL FILES    #
######################

#GUI
start .\Files\ExcelSampleData.xlsx
#PowerShell
#install module first if not installed already
if(-not (Get-Module ImportExcel -ListAvailable)){
  Install-Module ImportExcel -Scope CurrentUser -Force
}
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 20


####################
#     REMOTING     #
####################

#GUI
mstsc
#Powershell
$Servers = @(
  'Server1'
  'Server2'
  'Server3'
  'Server4'
  'Server5'
  'Server6'
)
Invoke-Command -ComputerName $Servers[0] -ScriptBlock {Get-ComputerInfo | Select-Object CSCaption, WindowsProductName,OSOrganization,BiosCaption,OsUptime,OsInstallDate,OsArchitecture}
Invoke-Command -ComputerName $Servers[0..1] -ScriptBlock {Get-EventLog -LogName Application -Newest 20}
Invoke-Command -ComputerName $Servers[0..2] -ScriptBlock {Get-ScheduledTask | Select-Object -First 20}
Invoke-Command -ComputerName $Servers[0..3] -ScriptBlock {Get-Process | Select-Object -First 20}
Invoke-Command -ComputerName $Servers[0..4] -ScriptBlock {Get-Service | Select-Object -First 20}
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-NetAdapter}
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-ChildItem}
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-Printer | Select-Object Name}

# Boring, most of the tasks are IT related
# Show me something good

###################
#       APIs      #
###################

#GUI
start https://pokeapi.co/api/v2/pokemon/snorlax/
#PowerShell
Invoke-RestMethod -Uri https://pokeapi.co/api/v2/pokemon/snorlax/ -Method get

# Get
# Post
# etc.

####################
#    Data Bases    #
####################

#GUI
start http://YourLanSweeperServer.com/Report/report.aspx?det=web50repassetsmenu
#Powershell
#install module first if not installed already
if(-not (Get-Module dbatools -ListAvailable)){
  Install-Module dbatools -Scope CurrentUser -Force
}
$query = "USE lansweeperdb;
Select Top 1000000 tblAssets.AssetID,
  tblAssets.AssetName,
  tsysAssetTypes.AssetTypename As AssetType,
  tsysAssetTypes.AssetTypeIcon10 As icon,
  tblAssets.Domain,
  Coalesce(tsysOS.OSname, tblLinuxSystem.OSRelease, tblMacOSInfo.SystemVersion)
  As OS,
  tblAssetCustom.Model,
  tblAssetCustom.Manufacturer,
  tblAssets.IPAddress,
  tsysIPLocations.IPLocation,
  tblAssets.Mac As MACAddress,
  tblADComputers.OU,
  tblState.Statename As State,
  tblAssets.Firstseen,
  tblAssets.Lastseen,
  tblAssets.Lasttried,
  tblAssets.Description,
  tblAssetCustom.PurchaseDate,
  tblAssetCustom.Warrantydate,
  tblAssets.FQDN,
  tblAssetCustom.DNSName,
  tblAssetCustom.LastPatched,
  tblAssetCustom.LastFullbackup,
  tblAssetCustom.LastFullimage,
  tblAssetCustom.Location,
  tblAssetCustom.Building,
  tblAssetCustom.Department,
  tblAssetCustom.Branchoffice,
  tblAssetCustom.BarCode,
  tblAssetCustom.Contact,
  tblAssetCustom.Serialnumber,
  tblAssetCustom.OrderNumber,
  tblAssetCustom.Custom1,
  tblAssetCustom.Custom2,
  tblAssetCustom.Custom3,
  tblAssetCustom.Custom4,
  tblAssetCustom.Custom5,
  tblAssetCustom.Custom6,
  tblAssetCustom.Custom7,
  tblAssetCustom.Custom8,
  tblAssetCustom.Custom9,
  tblAssetCustom.Custom10,
  tblAssetCustom.Custom11,
  tblAssetCustom.Custom12,
  tblAssetCustom.Custom13,
  tblAssetCustom.Custom14,
  tblAssetCustom.Custom15,
  tblAssetCustom.Custom16,
  tblAssetCustom.Custom17,
  tblAssetCustom.Custom18,
  tblAssetCustom.Custom19,
  tblAssetCustom.Custom20,
  Case tblAssetCustom.PreventCleanup
    When 0 Then 'No'
    When 1 Then 'Yes'
  End As PreventCleanup,
  tblAssets.Scanserver
From tblAssets
  Inner Join tblAssetCustom On tblAssets.AssetID = tblAssetCustom.AssetID
  Inner Join tsysAssetTypes On tsysAssetTypes.AssetType = tblAssets.Assettype
  Inner Join tsysIPLocations On tsysIPLocations.LocationID =
    tblAssets.LocationID
  Left Join tblADComputers On tblAssets.AssetID = tblADComputers.AssetID
  Inner Join tblState On tblState.State = tblAssetCustom.State
  Left Join tblLinuxSystem On tblAssets.AssetID = tblLinuxSystem.AssetID
  Left Join tsysOS On tblAssets.OScode = tsysOS.OScode
  Left Join tblMacOSInfo On tblAssets.AssetID = tblMacOSInfo.AssetID
Where tblAssets.Assettype <> 66
Order By tblAssets.AssetName;"

Invoke-DbaQuery -SqlInstance 'LanSweeperSQLServer' -Query $query | Select-Object AssetName, Model, IPAddress, IPLocation -First 20 | Format-Table


##########################
#    ACTIVE DIRECTORY    #
##########################

# GUI
dsa
#PowerShell
#You need to install the RSAT tools first for this to work
Get-ADUser -filter * | Select-Object SamAccountName -First 20
Get-ADGroup -Identity 'IT' | Select-Object Name,DistinguishedName
Get-ADGroupMember -Identity 'IT' | Select-Object Name
Get-ADGroupMember -Identity 'Purchasing' | Select-Object Name


#########################
#      TAKE AWAY        #
#########################

# You can retrieve data from ANY tool you use using PowerShell
# ###GET### -> FILTER -> DISPLAY

# Next Topic Filters
code '.\3 - Filter.ps1'