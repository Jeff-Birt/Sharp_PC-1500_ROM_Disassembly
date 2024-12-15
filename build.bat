@echo off
REM Tell TASM where to find the correct table to use
REM We are using the lh5801 table
set TASMTABS=%TASM%\tasmTab\
REM Move up to the TASM 'install' directory 
REM call TASM with build args and source file name


@echo Building low bank
%TASM%\tasm323\Tasm323.exe -x7 -g3 -5801 PC-1500_ROM-A03.lh5801.asm 
del PC-1500_ROM-A03.bin
ren PC-1500_ROM-A03.obj PC-1500_ROM-A03.bin


:endparse
