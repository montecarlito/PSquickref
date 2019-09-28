# Get Malware
# $malware = Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | where LastWriteTime -gt (Get-Date).AddMinutes(-60) | where Name -match "\.exe$"
$malware = $(Get-ChildItem -Path C:\ -Recurse -ErrorAction SilentlyContinue | where Name -match "atropia").Directory | Get-ChildItem

# Corrupt each file
# Ref: https://social.technet.microsoft.com/Forums/Lync/en-US/c5ea0ff8-f164-414f-a507-811a086a6b61/how-can-i-write-binary-files-in-powershell-?forum=winserverpowershell
foreach ($file in $malware) {
    # Get file's metadata
    $last_write_time = $file.LastWriteTime
    $last_access_time = $file.LastAccessTime
    $hash = $(Get-FileHash $file.FullName -Algorithm MD5).Hash
    Write-Host "$file before: $hash"

    # Read file
    $bytes = [System.IO.File]::ReadAllBytes($file.fullname)

    # Corrupt ten random bytes
    foreach ($iteration in 0..9) {
        $index = Get-Random -Minimum 0 -Maximum $($bytes.Length-1)
        $bytes[$index] = $bytes[$index] -bxor 0xFF
    }
    # Write corrupt data
    [System.IO.File]::WriteAllBytes($file.FullName, $bytes)

    # Reset timestamps
    $file.LastWriteTime = $last_write_time
    $file.LastAccessTime = $last_access_time

    $hash = $(Get-FileHash $file.FullName -Algorithm MD5).Hash
    Write-Host "$file after:  $hash"
}

# TODO: Stomp log entries
