foreach ($p in Get-Process) {
    Write-Host Process: $p.Name
    Write-Host DLLs:
    foreach ($m in $p.Modules) {
        # Write-Host $m.ModuleName
        Write-Host $m.FileName
    }
    Write-Host "-----------------------------------"
}