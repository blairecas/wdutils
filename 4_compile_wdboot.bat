@echo off

rem compile wdmain
php -f ../scripts/preprocess.php wdmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _wdmain.lst _wdmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _wdmain.lst _wdmain.bin bin 1000
if %ERRORLEVEL% NEQ 0 ( exit /b )

rem pack wdmain
..\scripts\zx0 -f _wdmain.bin _wdmain_lz.bin

rem compile wdboot
php -f ../scripts/preprocess.php wdboot.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _wdboot.lst _wdboot.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _wdboot.lst _wdboot.bin bin 0 10000
if %ERRORLEVEL% NEQ 0 ( exit /b )

rem create images
copy /b _wdboot.bin+wdboot_zero.bin release\ide_wdromv0200.bin >NUL
copy /b atmbeg.bin+_wdboot.bin+atmend.bin release\m324pa.raw >NUL

rem remove not needed files
del _wdmain.mac
del _wdmain.lst
del _wdmain.bin
del _wdmain_lz.bin
del _wdboot.mac
del _wdboot.lst
del _wdboot.bin

emulator\ukncbtl
