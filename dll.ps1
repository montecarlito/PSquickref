# Create an array to collect all the unique DLL names
$all = @()

# Iterate through all the active processes
ForEach ($p in Get-Process) {
  # Status line
  Write-Output "================ Process $($p.Name) (PID $($p.Id)) ================="
  # Now iterate through all the modules (after sorting) for each process
  ForEach ($m in $p.Modules | Sort) {
    # Remove the .exe entries
    If ($m.FileName -NotMatch "\.exe") {
      # output for user
      Write-Output "    $($m.FileName)"
      
      # If not already in the list of unique DLL names
      If ($all -NotContains $m.FileName) {
        # Then add it to the list of unique DLL names
        $all += $m.FileName
      }
    }
  }
  Write-Output ""
}

Write-Output ""
Write-Output "====================================================="
Write-Output "====================================================="
Write-Output "====================================================="
Write-Output "====================================================="
Write-Output ""

# Second part, list all the DLL's, after sorting
ForEach ($a in $all | Sort) {
  Write-Output "DLL: $a"
}