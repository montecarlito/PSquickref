param (
    [Parameter(Position=0,Mandatory=$True)]
    [string]$output
)


foreach ($x in "HKLM","HKCU") {
    reg.exe export $($x) $($x+"_"+$output+".reg")
}
