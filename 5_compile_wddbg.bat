@echo off

rem compile 
php -f ../scripts/preprocess.php wddbg.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _wddbg.lst _wddbg.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _wddbg.lst release/wddbg.sav sav
if %ERRORLEVEL% NEQ 0 ( exit /b )

..\scripts\rt11dsk.exe d release\diska.dsk wddbg.sav >NUL
..\scripts\rt11dsk.exe a release\diska.dsk release\wddbg.sav >NUL

rem remove not needed files
del _wddbg.mac
del _wddbg.lst

rem c:\Projects\uknc\ukncbtl\sav2cart release\wddbg.sav release\wddbg.bin

emulator\ukncbtl