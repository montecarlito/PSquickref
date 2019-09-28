# Allow inbound Telnet traffic. Doesn't create log event.
$reg_path = "HKLM:\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
# Get firewall rule for port 23
# $rule = Get-ItemProperty -Path $reg_path | Get-Member | where Definition -match "name=TELNET"
$rule = Get-NetFirewallPortFilter -Protocol TCP | where LocalPort -eq 23 | Get-NetFirewallRule
# Get value for key entry
$value = (Get-ItemProperty -Path $reg_path -Name $rule.Name).$($rule.Name)
# Replace "Block" with "Allow"
$new_definition = $value -replace "Action=Block","Action=Allow"
# Update firewall rule
# Ref: https://blogs.technet.microsoft.com/heyscriptingguy/2015/04/02/update-or-add-registry-key-value-with-powershell/
New-ItemProperty -Path $reg_path -Name $rule.Name -Value $new_definition -PropertyType String -Force | Out-Null

# Allow inbound Telnet traffic. Creates a log event.
New-NetFirewallRule -DisplayName "Allow Inbound Telnet TCP" -Direction Inbound -LocalPort 23 -Protocol TCP -Action Allow

# Disable credential validation
# Ref: https://rustywinadmin.wordpress.com/tag/audit-policy-by-powershell/
Invoke-Expression -Command 'auditpol.exe /set /subcategory:"credential validation" /success:disable /failure:disable'

# Get firewall event logs
$temp_date = Get-Date
$today = Get-Date -Year $temp_date.Year -Month $temp_date.Month -Day $temp_date.Day -Hour 0 -Minute 0 -Second 0
Get-WinEvent -LogName "Microsoft-Windows-Windows Firewall With Advanced Security/Firewall" | where TimeCreated -gt $today
