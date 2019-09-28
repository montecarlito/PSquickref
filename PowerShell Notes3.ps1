Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Get-Process | where { $_.id -lt 1000 }
#where is the condition (filter) by which PIDs are the factor
Get-Process | where { $_.id -lt 1000 } | select handles, id, processname
#selct is an additional condition