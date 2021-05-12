PS G:\> $d = [system.convert]::frombase64string("<base64-encoded string>")
PS G:\> [system.text.encoding]::utf8.getstring($d)

#OR

PS G:\> [system.text.encoding]::utf8.getstring([system.convert]::frombase64string("<base64-encoded string>"))