@echo off

rem compile wdr2
php -f ../scripts/preprocess.php wdr2.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _wdr2.lst _wdr2.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _wdr2.lst release/wdr2.sav sav
if %ERRORLEVEL% NEQ 0 ( exit /b )

..\scripts\rt11dsk.exe d release\diska.dsk wdr2.sav >NUL
..\scripts\rt11dsk.exe a release\diska.dsk release\wdr2.sav >NUL

rem remove not needed files
del _wdr2.mac
del _wdr2.lst

emulator\ukncbtl
