@echo off

rem compile wdinit.mac to binary
php -f ../scripts/preprocess.php wdinit.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _wdinit.lst _wdinit.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _wdinit.lst _wdinit.bin bin 0 24000
if %ERRORLEVEL% NEQ 0 ( exit /b )

rem make floppy image
copy /b _wdinit.bin+wdinit_data.bin release\wdinit.dsk >NUL

rem remove not needed files
del _wdinit.bin
del _wdinit.mac
del _wdinit.lst

emulator\ukncbtl
