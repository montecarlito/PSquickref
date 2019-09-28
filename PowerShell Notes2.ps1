cd env:
$env:USERNAME
cd C:\Users\Trainee
Get-Process [0]
(get-process).Name
(Get-Process).Name | foreach { write-output "$_ is a proc" }
#gets array of process names and writes output "is a proc" next to each
foreach ($p in get-process) { Write-Output "$($p.name) is a proc" }
#does the same thing
$a=1..5; foreach ($i in $a) { Write-Output "$i is a number" }
#variable a=(1 thru 5) and for each line do write ouput is a number
$a
$x=0; while ($x -lt 10) { Write-Output "loop number $x"; $x++ }
#variable x=0 and while x<10, do write-output loop number [$x] then add one to [$x]
$x=0; while ($x -lt 10) { Write-Output "loop number $x"; ++$x }
#same
function do-stuff { Get-Date; date-process; Get-Service }
function do-stuff {
    Get-Date
    Get-Process
    Get-Service
}
#different ways to call a function (ex: do-stuff) into play
Get-WmiObject -Class win32_bios
$bios = Get-WmiObject -Class win32_bios
$bios
$bios.Manufacturer
$bios.Name
$bios.Version
Get-WmiObject -Class win32_bios | Get-Member
