# Definitely need to add more registry locations
$locations = @(
  "HKCU:\Software\Sysinternals",
  "HKLM:\Software\Microsoft\Windows\Shell"
)

# Collect all the relevant registry keys
Function RegSnap {
  ForEach ($loc in $locations) {
    # Can't really do much about keys that we can't read, so ignore errors
    $allKeys = Get-ChildItem $loc -Recurse -ErrorAction SilentlyContinue
    Write-Output "===== Processing $loc"
    # .Name starts with HKEY_CURRENT_USER instead of HKCU:, so we use .PSPath instead
    ForEach ($key in $allKeys.PSPath) {
      Get-ItemProperty -Path $key -Name * -ErrorAction SilentlyContinue
    }
  }
}

$testPath = "$($locations[0])\RegSnap"
$temp1 = "$($Env:Temp)\RegSnap1.out"
$temp2 = "$($Env:Temp)\RegSnap2.out"

# Run it once
RegSnap > $temp1

# Create a new property / value pair
Write-Output "===== Creating a temporary key / prop / value"
New-Item -Path $testPath
New-ItemProperty -Path $testPath -Name "xyz" -Value 456

# Run it again
RegSnap > $temp2

Write-Output "===== Comparing before / after adding a property / value pair"
Compare-Object (Get-Content $temp1) (Get-Content $temp2) | Format-Table

# Remove the new property / value pair
Remove-Item -Path $testPath
