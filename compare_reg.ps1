param (
    [Parameter(Position=0,Mandatory=$True)]
    [string]$base,
    [Parameter(Position=1,Mandatory=$True)]
    [string]$compare
)


Write-Host $(Compare-Object `
    -ReferenceObject $(Get-Content -Path $base) `
    -DifferenceObject $(Get-Content -Path $compare) `
    -PassThru)

# fc.exe /U /W $base $compare
