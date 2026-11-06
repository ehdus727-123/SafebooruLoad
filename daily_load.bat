@echo off
setlocal EnableExtensions

rem ===== settings =====
set "SRC=C:\safebooru_run\crawler\output"
set "WORK=C:\safebooru_load"
set "MARIADB=C:\Program Files\MariaDB 13.0\bin\mariadb.exe"
rem ====================

set "LOG=%WORK%\load.log"

if not exist "%MARIADB%" (
  echo [%date% %time%] mariadb.exe not found: %MARIADB%>>"%LOG%"
  exit /b 1
)

for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMM"') do set "M0=%%i"
for /f "usebackq" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-1) | Get-Date -Format yyyyMM"`) do set "M1=%%i"

for %%M in (%M1% %M0%) do call :load %%M
exit /b 0

:load
if not exist "%SRC%\%1.csv" (
  echo [%date% %time%] %1.csv not found, skipped>>"%LOG%"
  exit /b 0
)
copy /y "%SRC%\%1.csv" "%WORK%\current.csv" >nul
if errorlevel 1 (
  echo [%date% %time%] copy failed: %1.csv>>"%LOG%"
  exit /b 1
)
echo [%date% %time%] loading %1.csv>>"%LOG%"
"%MARIADB%" --defaults-extra-file="%WORK%\sb.cnf" --local-infile=1 safebooru < "%WORK%\load.sql" >>"%LOG%" 2>&1
if errorlevel 1 (
  echo [%date% %time%] load FAILED: %1.csv>>"%LOG%"
) else (
  echo [%date% %time%] load ok: %1.csv>>"%LOG%"
)
exit /b 0