[CmdletBinding()]
param (
[Parameter(Position=0,Mandatory=$True)]
[string]$Baseline,
[Parameter(Position=1,Mandatory=$True)]
[string]$Comparison
)
Write-Output "COMPARISON RESULTS: "
Compare-Object -ReferenceObject (Get-Content $Baseline) -DifferenceObject (Get-Content $Comparison) | Format-List | Write-Output