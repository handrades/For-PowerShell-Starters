break

#################### What do I FILTER? .NET Objects
#################### Why do I want to FILTER? 7 years of experience tell me is because analytics
#################### When do I FILTER? When the BOSS starts asking questions.
#################### How can I FILTER? just PIPE it to WHERE, GROUP, SORT, MEASURE, SELECT

####################
#  WINDOWS EVENTS  #
####################

#PowerShell
Get-EventLog -LogName Application -Newest 1 | Get-Member # Grab the latest event log and show me all its methods and properties
#In PowerShell you apply filters to properties, so let's concentrate on just properties
Get-EventLog -LogName Application -Newest 1 | Get-Member | Where-Object MemberType -like '*Property*'
#Now that we know the object's properties we can now start applying filters to it

#############
# Example 1 #
#############
Get-EventLog -LogName Application -Newest 15
# Look at your data and add a filter
Get-EventLog -LogName Application -Newest 15 | Where-Object InstanceID -NE 0 # -NE means Not Equal or != in most programing languages
# Look at your data and add a filter
Get-EventLog -LogName Application -Newest 15 | Group-Object EntryType
# Look at your data and add a filter
Get-EventLog -LogName Application -Newest 15 | Sort-Object Message
# Look at your data and add a filter
Get-EventLog -LogName Application -Newest 15 | Select-Object Source,InstanceID,Message

# Look at your data and add a filter
Get-EventLog -LogName Application | Measure-Object
#GUI
eventvwr



#####################
#  SCHEDULED TASKS  #
#####################

#PowerShell
# First discover all the Scheduled Tasks Object MemberTypes
Get-ScheduledTask | Get-Member
# Second list all the Scheduled Tasks Object MemberTypes Properties
Get-ScheduledTask | Get-Member | Where-Object MemberType -like '*Property*'
#Now that we know the object's properties we can now estart applying filters to it

#############
# Example 2 #
#############
#Display all the objects
Get-ScheduledTask
#Start Applying filters to the properties
Get-ScheduledTask | Where-Object State -eq Running
Get-ScheduledTask | Group-Object TaskPath
Get-ScheduledTask | Group-Object TaskPath | Sort-Object Count
Get-ScheduledTask | Group-Object TaskPath | Sort-Object Count | Where-Object Count -gt 1
Get-ScheduledTask | Group-Object TaskPath | Sort-Object Count | Where-Object Count -gt 3 | Select-Object Name
Get-ScheduledTask | Measure-Object
#GUI
taskschd

#####################
#   TASKS MANAGER   #
#####################

#PowerShell
# First discover all the TASKS MANAGER Object MemberTypes
Get-Process | Get-Member
# Second list all the TASKS MANAGER Object MemberTypes Properties
Get-Process | Get-Member | Where-Object MemberType -like '*Property*'

#Now try it yourself
#Display all the objects
Get-Process
#Start Applying filters to the properties
Get-Process | Group-Object
# Read your data and add a filter
Get-Process | Group-Object  | Sort-Object
# Read your data and add a filter
Get-Process | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-Process | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-Process | Measure-Object
#GUI
taskmgr

################
#   SERVICES   #
################

#PowerShell
# First discover all the SERVICES Object MemberTypes
Get-Service | Get-Member
# Second list all the SERVICES Object MemberTypes Properties
Get-Service | Get-Member | Where-Object MemberType -like '*Property*'


# Now try it yourself
# Display all the objects
Get-Service
# Start Applying filters to the properties
Get-Service | Group-Object
# Read your data and add a filter
Get-Service | Group-Object  | Sort-Object
# Read your data and add a filter
Get-Service | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-Service | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-Service | Measure-Object
#GUI
taskmgr


########################
#   NETWORK ADAPTERS   #
########################

#PowerShell
##Now try it yourself
# First discover all the NETWORK ADAPTERS Object MemberTypes
Get-NetAdapter | Get-Member
# Second list all the NETWORK ADAPTERS Object MemberTypes Properties
Get-NetAdapter | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Get-NetAdapter
# Read your data and add a filter
Get-NetAdapter | Group-Object
# Read your data and add a filter
Get-NetAdapter | Group-Object  | Sort-Object
# Read your data and add a filter
Get-NetAdapter | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-NetAdapter | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-NetAdapter | Measure-Object
#GUI
ncpa


####################
#       FILES      #
####################

#PowerShell
##Now try it yourself
# First discover all the FILES Object MemberTypes
Get-ChildItem | Get-Member
# Second list all the FILES Object MemberTypes Properties
Get-ChildItem | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Get-ChildItem
# Read your data and add a filter
Get-ChildItem | Group-Object
# Read your data and add a filter
Get-ChildItem | Group-Object  | Sort-Object
# Read your data and add a filter
Get-ChildItem | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-ChildItem | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-ChildItem | Measure-Object
#GUI
Invoke-Item .


#######################
#       PRINTERS      #
#######################

#PowerShell
##Now try it yourself
# First discover all the PRINTERS Object MemberTypes
Get-Printer | Get-Member
# Second list all the PRINTERS Object MemberTypes Properties
Get-Printer | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Get-Printer
# Read your data and add a filter
Get-Printer | Group-Object
# Read your data and add a filter
Get-Printer | Group-Object  | Sort-Object
# Read your data and add a filter
Get-Printer | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-Printer | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-Printer | Measure-Object
#GUI
control printers


############################
#    INSTALLED PROGRAMS    #
############################

# Wiped and reloaded my PC 2 days ago. Woops
#GUI
appwiz
##Now try it yourself
# First discover all the INSTALLED PROGRAMS Object MemberTypes
Get-Package | Get-Member
# Second list all the INSTALLED PROGRAMS Object MemberTypes Properties
Get-Package | Get-Member | Where-Object MemberType -like '*Property*'
# In PowerShell you also install the application you need to do what you need to do

# Display all the objects
Get-Package
# Read your data and add a filter
Get-Package | Group-Object
# Read your data and add a filter
Get-Package | Group-Object  | Sort-Object
# Read your data and add a filter
Get-Package | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-Package | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-Package | Measure-Object


#####################
#     TEXT FILES    #
#####################

#PowerShell
##Now try it yourself
# First discover all the TEXT FILES Object MemberTypes
Import-Csv -Path .\Files\SampleData.csv | Select-Object -first 1 | Get-Member
# Second list all the TEXT FILES Object MemberTypes Properties
Import-Csv -Path .\Files\SampleData.csv | Select-Object -first 1 | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Import-Csv -Path .\Files\SampleData.csv | Select-Object -first 1
(Import-Csv -Path .\Files\SampleData.csv)[0] #Select the first record and give me all its columns
#lines 233 and 234 are equivalent

# Read your data and add a filter
Import-Csv -Path .\Files\SampleData.csv | Group-Object
# Read your data and add a filter
Import-Csv -Path .\Files\SampleData.csv | Group-Object | Sort-Object
# Read your data and add a filter
Import-Csv -Path .\Files\SampleData.csv | Group-Object | Sort-Object | Select-Object
# Read your data and add a filter
Import-Csv -Path .\Files\SampleData.csv | Group-Object | Sort-Object | Select-Object | Where-Object
Import-Csv -Path .\Files\SampleData.csv | Measure-Object
#GUI
start .\Files\SampleData.csv


######################
#     EXCEL FILES    #
######################

#PowerShell
##Now try it yourself
# First discover all the EXCEL FILES Object MemberTypes
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 1 | Get-Member
# Second list all the EXCEL FILES Object MemberTypes Properties
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 1 | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 1
# Read your data and add a filter
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 20 | Group-Object
# Read your data and add a filter
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 20 | Group-Object  | Sort-Object
# Read your data and add a filter
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 20 | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Import-Excel -Path .\Files\ExcelSampleData.xlsx -EndRow 20 | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Import-Excel -Path .\Files\ExcelSampleData.xlsx | Measure-Object
#GUI
start .\Files\ExcelSampleData.xlsx

####################
#     REMOTING     #
####################

#GUI
mstsc
##Now try it yourself
$Servers = @(
  'Server1'
  'Server2'
  'Server3'
  'Server4'
  'Server5'
  'Server6'
)
Invoke-Command -ComputerName $Servers[0] -ScriptBlock {Get-ComputerInfo | Select-Object CSCaption, WindowsProductName,OSOrganization,BiosCaption,OsUptime,OsInstallDate,OsArchitecture}
Invoke-Command -ComputerName $Servers[0..1] -ScriptBlock {Get-EventLog -LogName Application -Newest 20 | Where-Object }
Invoke-Command -ComputerName $Servers[0..2] -ScriptBlock {Get-ScheduledTask | Select-Object -First 20 | Group-Object }
Invoke-Command -ComputerName $Servers[0..3] -ScriptBlock {Get-Process | Select-Object -First 20 | Sort-Object }
Invoke-Command -ComputerName $Servers[0..4] -ScriptBlock {Get-Service | Measure-Object }
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-NetAdapter | Where-Object }
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-ChildItem | Group-Object }
Invoke-Command -ComputerName $Servers[0..5] -ScriptBlock {Get-Printer | Select-Object }


###################
#       APIs      #
###################

#GUI
#PluralSight Admin Portal I don't have access to????
##Now try it yourself
#PowerShell
$API = Invoke-RestMethod -Uri https://pokeapi.co/api/v2/pokemon/snorlax/ -Method get
# No columns... What now?
# First discover all the TASKS MANAGER Object MemberTypes
$API | Get-Member
# Second list all the TASKS MANAGER Object MemberTypes Properties
$API | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
$API
# Read your data and add a filter
$API | Where-Object
# Read your data and add a filter
$API | Group-Object  | Sort-Object
# Read your data and add a filter
$API | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
$API | Group-Object  | Sort-Object  | Select-Object  | Where-Object
$API | Measure-Object

#GUI
start https://pokeapi.co/api/v2/pokemon/snorlax/

####################
#    Data Bases    #
####################

#GUI
start http://YourLanSweeperServer.com/Report/report.aspx?det=web50repassetsmenu
##Now try it yourself
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

$DataBase = Invoke-DbaQuery -SqlInstance 'LanSweeperSQLServer' -Query $query
# First discover all the Data Bases Object MemberTypes
$DataBase | Get-Member
# Second list all the Data Bases Object MemberTypes Properties
$DataBase | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
$DataBase
# Read your data and add a filter
$DataBase | Group-Object
# Read your data and add a filter
$DataBase | Group-Object  | Sort-Object
# Read your data and add a filter
$DataBase | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
$DataBase | Group-Object  | Sort-Object  | Select-Object  | Where-Object
$DataBase | Measure-Object


##########################
#    ACTIVE DIRECTORY    #
##########################

# GUI
dsa
##Now try it yourself
# First discover all the ACTIVE DIRECTORY Object MemberTypes
Get-ADGroupMember -Identity 'IT Mail' | Get-Member
# Second list all the ACTIVE DIRECTORY Object MemberTypes Properties
Get-ADGroupMember -Identity 'IT Mail' | Get-Member | Where-Object MemberType -like '*Property*'

# Display all the objects
Get-ADGroupMember -Identity 'IT Mail'
# Read your data and add a filter
Get-ADGroupMember | Group-Object
# Read your data and add a filter
Get-ADGroupMember | Group-Object  | Sort-Object
# Read your data and add a filter
Get-ADGroupMember | Group-Object  | Sort-Object  | Select-Object
# Read your data and add a filter
Get-ADGroupMember | Group-Object  | Sort-Object  | Select-Object  | Where-Object
Get-ADGroupMember | Measure-Object


#########################
#      TAKE AWAY        #
#########################

# Once you have the data. You can apply analytics to it using PowerShell. No matter where the data comes from.
# GET -> ###FILTER### -> DISPLAY

# Next Topic Display. One of my favorite topics.
code '.\4 - Display.ps1'