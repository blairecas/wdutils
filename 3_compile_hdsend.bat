@echo off

rem compile
php -f ../scripts/preprocess.php hdsend.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -m ..\scripts\sysmac.sml -l _hdsend.lst _hdsend.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _hdsend.lst release/hdsend.bin bin 0 1000
if %ERRORLEVEL% NEQ 0 ( exit /b )

rem remove not needed
del _hdsend.mac
del _hdsend.lst

rem compile c++
cl hdsend.cpp
del hdsend.obj
move/y hdsend.exe release\hdsend.exe
