@echo off
REM Configures the environment variables required to build neonLIBRARY projects.
REM 
REM 	buildenv [ <source folder> ]
REM
REM Note that <source folder> defaults to the folder holding this
REM batch file.
REM
REM This must be [RUN AS ADMINISTRATOR].

echo ==============================================
echo * neonLIBRARY Build Environment Configurator *
echo ==============================================

REM Default NL_ROOT to the folder holding this batch file after stripping
REM off the trailing backslash.

set NL_ROOT=%~dp0 
set NL_ROOT=%NL_ROOT:~0,-2%

if not [%1]==[] set NL_ROOT=%1

if exist %NL_ROOT%\neonLIBRARY.sln goto goodPath
echo The [%NL_ROOT%\neonLIBRARY.sln] file does not exist.  Please pass the path
echo to the Neon solution folder.
goto done

:goodPath 

REM Set NC_REPOS to the parent directory holding the neonFORGE repositories.

pushd "%NL_ROOT%\.."
set NC_REPOS=%cd%
popd

REM Configure the other environment variables.

set NL_TOOLBIN=%NL_ROOT%\ToolBin
set NL_BUILD=%NL_ROOT%\Build
set NL_CACHE=%NL_ROOT%\Build-cache
set NL_TEST=%NL_ROOT%\Test
set NL_TEMP=C:\Temp

echo.
echo Persisting state...
echo.

REM Persist the environment variables.

setx NC_REPOS "%NC_REPOS%" /M                     > nul
setx NL_ROOT "%NL_ROOT%" /M                       > nul
setx NL_TOOLBIN "%NL_TOOLBIN%" /M                 > nul
setx NL_BUILD "%NL_BUILD%" /M                     > nul
setx NL_CACHE "%NL_CACHE%" /M                     > nul
setx NL_TEST "%NL_TEST%" /M                       > nul
setx NL_TEMP "%NL_TEMP%" /M                       > nul
setx NL_ACTIONS_ROOT "%NL_ACTIONS_ROOT%" /M       > nul
setx NL_NUGET_DEVFEED "%NL_NUGET_DEVFEED%" /M     > nul
setx NL_NUGET_VERSIONER "%NL_NUGET_VERSIONER%" /M > nul

REM Make sure required folders exist.

if not exist "%NL_TEMP%" mkdir "%NL_TEMP%"
if not exist "%NL_TOOLBIN%" mkdir "%NL_TOOLBIN%"
if not exist "%NL_BUILD%" mkdir "%NL_BUILD%"

REM Configure the PATH.

%NL_TOOLBIN%\pathtool -dedup -system -add "%NL_BUILD%"
%NL_TOOLBIN%\pathtool -dedup -system -add "%NL_TOOLBIN%"

REM Perform remaining initialization in Powershell.

pwsh -File "%NL_ROOT%"\buildenv.ps1

:done
echo ============================================================================================
echo * Be sure to close and reopen Visual Studio and any command windows to pick up the changes *
echo ============================================================================================
pause
