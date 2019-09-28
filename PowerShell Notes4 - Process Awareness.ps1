Select-Location C:\Program Files #jacking into the path for Sysinternal tools
sc.exe
sc.exe queryex eventlog #shows STATE and FLAGS
sc.exe qc eventlog #shows file path, display name & dependencies which may tell you if it's malware (ex- system file in Temp)
tasklist /FI "pid eq 602" /v
tasklist /FI "pid eq 602" /svc
Get-Random -InputObject $(get-service) -Count 5
sc.exe queryex irmon
sc.exe qc irmon
Get-Service irmon
wmic service irmon list full #gives all the above plus Description, ErrorControl & Code, Svc Type & Status
psservice.exe query irmon