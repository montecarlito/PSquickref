function Enumeration() {
#System date and time
"`nSystem Date and Time: " + "$(Get-Date)" | Write-Output
#Hostname
"`nHostname: " + $env:COMPUTERNAME | Write-Output
#Users and groups
write-output "`nUsers: "
Get-LocalUser | Select-Object Name | Write-Output
Write-Output "`nGroups: "
Get-LocalGroup | Select-Object Name | Write-Output
#Logged on users
Write-Output "`nLogged On Users: "
(Get-WmiObject win32_loggedonuser | select antecedent) -split "," -match "Name=" -split "=" -notmatch "Name" -replace "}",""
#Running processes sorted by ProcessName & Path, excluding duplicates
Write-Output "`nProcesses: "
Get-Process | Select-Object ProcessName,Path | Sort-Object Processname,Path -unique | out-string | Write-Output
#Services and their states
Write-Output "`nServices: "
Get-WmiObject win32_service | Select-Object Name,State | out-string | Write-Output
#Network information sorted by IPAddress
Write-Output "`nNetworks: "
Get-NetIPAddress | Select-Object IPAddress,InterfaceAlias | Sort-object IPAddress | Out-String | Write-Output
#Listening network sockets
Write-Output "`nListening Sockets: "
Get-NetTCPConnection -State Listen | Sort-Object LocalAddress,LocalPort | Out-String | Write-Output
#System con􀀡guration information
Write-Output "`nSystem Configuration Information: "
Write-Output "`nWindows Version: "
Get-WmiObject win32_operatingsystem | Select-Object Version | Out-String | Write-Output
Write-Output "`nHotfixes: "
Get-HotFix | Out-String | Write-Output
Write-Output "`nSystem Info: "
Get-WmiObject win32_computersystem | out-string | write-output
#Mapped drives
Write-Output "`nMapped Drives: "
Get-WmiObject win32_logicaldisk | Select-Object DeviceID | Out-String | Write-Output
#Plug and play devices
Write-Output "`nPnP Devices: "
Get-PnpDevice | Select-Object InstanceID | Sort-Object | Out-String | Write-Output
#Shared resources
Write-Output "`nShared Resources: "
Get-WmiObject win32_share | Out-String | Write-Output
#Scheduled tasks
Write-Output "`nScheduled Tasks: "
Get-ScheduledTask | Out-String | Write-Output
}
$timestamp= Get-Date -Format "yyyyMMddHHmmss"
Enumeration > Enumeration_$timestamp.txt