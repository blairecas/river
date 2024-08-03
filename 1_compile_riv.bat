@echo off

echo .
echo ===========================================================================
echo Graphics
echo ===========================================================================
php -f ./scripts/conv_fnt.php
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ./scripts/conv_spr.php
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ./scripts/conv_menu_img.php ./graphics/menu/mig.png
if %ERRORLEVEL% NEQ 0 ( exit /b )

echo.
echo ===========================================================================
echo Compiling CPU
echo ===========================================================================
php -f ../scripts/preprocess.php acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -l _acpu.lst _acpu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _acpu.lst _acpu.bin bin 0
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\zx0 -f _acpu.bin _acpu_lz.bin

echo.
echo ===========================================================================
echo Compiling PPU
echo ===========================================================================
php -f ../scripts/preprocess.php appu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -l _appu.lst _appu.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _appu.lst _appu.bin bin 0
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\zx0 -f _appu.bin _appu_lz.bin

echo.
echo ===========================================================================
echo Compiling MAIN
echo ===========================================================================
php -f ../scripts/preprocess.php bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
..\scripts\macro11 -ysl 32 -yus -l _bmain.lst _bmain.mac
if %ERRORLEVEL% NEQ 0 ( exit /b )
php -f ../scripts/lst2bin.php _bmain.lst ./release/riv.sav sav

..\scripts\rt11dsk.exe d main.dsk .\release\riv.sav >NUL
..\scripts\rt11dsk.exe a main.dsk .\release\riv.sav >NUL

echo.