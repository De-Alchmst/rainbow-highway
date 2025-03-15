@echo off
setlocal enabledelayedexpansion

set command=fpc Main.pas -FUCompiled

if "%~1"=="" goto usage
if /i not "%~1"=="-s" if /i not "%~1"=="-d" goto usage

if /i "%~1"=="-s" (
    set command=!command! -dSTATIC
)

for /d %%D in (*) do (
    set command=!command! -Fu%%D
)

%command%
goto :eof

:usage
echo Usage:
echo   compile.bat {-s^|-d}
echo      -s     link raylib statically
echo      -d     link raylib dynamically
echo.
echo Before recompiling in the other mode, run 'clear.bat'
exit /b 1