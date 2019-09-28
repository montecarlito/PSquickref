﻿get-childitem -Recurse -ErrorAction SilentlyContinue HKLM:\SYSTEM | ForEach-Object {Get-ItemProperty -path $_.PsPath} | out-file C:\Users\student\desktop\hklmsystem_baseline.txt
get-childitem -Recurse -ErrorAction SilentlyContinue HKLM:\SOFTWARE | ForEach-Object {Get-ItemProperty -path $_.PsPath} | out-file C:\Users\student\desktop\hklmsoftware_baseline.txt
get-childitem -Recurse -ErrorAction SilentlyContinue HKCU:\SOFTWARE | ForEach-Object {Get-ItemProperty -path $_.PsPath} | out-file C:\Users\student\desktop\hkcu_baseline.txt