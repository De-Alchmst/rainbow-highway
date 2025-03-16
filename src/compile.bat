@echo off
setlocal enabledelayedexpansion

set command=fpc Main.pas -FUCompiled

for /d %%D in (*) do (
    set command=!command! -Fu%%D
)

if not exist Compiled mkdir Compiled
%command%
