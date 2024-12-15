# PC-1500_ROM build script
# Usage: './build.psa -l' builds left bank, '-r' right bank
#        './build.psa -b NAME' builds both banks and merge into file 'CE-158_ROM_NAME.bin'
# Building also creates a function map for each bank named 'CE-158_ROM_LOW.NAME.FMap'
# by - Hey Birt!

$Env:TASMTABS = $Env:TASM + "\tasmTab\"
$exe = $Env:TASM + '\tasm323\Tasm323.exe'

# Loop through each recipie entry and build it
$out_name = "PC-1500_ROM.lh5801.asm"

Write-Host "Building $out_name"
& $exe -x7 -g3 -5801  'PC-1500_ROM.lh5801.asm'

# Start-Sleep -Seconds 1 # give time for .bin file to appear

# # We need to rename the .obj output by TASM to .bin
# if ([System.IO.File]::Exists("PC-1500_ROM.bin")) {
#     Remove-Item -Path "PC-1500_ROM.bin"
# }
# else {
#     Write-Host ""PC-1500_ROM.bin" not found"
# }

# if ([System.IO.File]::Exists("PC-1500_ROM.obj")) {
#     Rename-Item -Path "PC-1500_ROM.obj" -NewName "PC-1500_ROM.bin"
# }
# else {
#     Write-Host "PC-1500_ROM.obj not found"
# }

# # #Create a function map from .lst file and then prepend header to it
# # $bobB = $bob
# # if ($args[0] -eq '-b') {$bobB = "$bobB.$($args[1])"}
# # Get-Content "CE-158_ROM_$bob.lst" | select-string -pattern ";%" -encoding ASCII | Set-Content "CE-158_ROM_$bob.FMap"
# # Start-Sleep -Seconds 1 # give time for .FMap file to appear

# # @("Line   Address          Name") + (Get-Content "CE-158_ROM_$bob.FMap") | Set-Content "CE-158_ROM_$bobB.FMap"
# # Write-Host "$bob Bank Function Map generated"


