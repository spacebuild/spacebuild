@ECHO OFF
setlocal EnableDelayedExpansion
REM #############################
REM	      --Spawnlister--       #
REM	   Spawnlist generator for  #
REM	        Garry's Mod         #
REM	                            #
REM	Contact: CerusVI@Gmail.com  #
REM #############################

REM Init variables, mostly just for organization.
SET modelpath=
SET count=
SET SPAWNLIST=
SET loopstop=1
SET WorkingDIR=%~dp0
SET SUBD=

REM Walk backwards through directory structure to find the root
REM /models/ subdirectory when executed from any model subfolder.
ECHO Finding root model directory...
:FindModelRoot
REM Infinite loop avoidance if it can't find a folder named "models" in less than 25 tries.
IF %loopstop% gtr 25 EXIT
SET TempDIR=%CD%
CD ..
SET RootDIR=!TempDIR:%CD%=!
SET /a loopstop+=1
IF NOT "%RootDIR%"=="\models" GOTO FindModelRoot
CD %WorkingDIR%
ECHO Got it.


REM Clean up temp files if they exist.
IF EXIST modelprep.txt del modelprep.txt

:UserOptions
REM Get user options.
ECHO Include subdirectories?

SET /p SUBSD=[y/n]^>
IF "%SUBSD%"== "y" (
GOTO IncludeSubD
) else (
GOTO ExcludeSubD
)

:IncludeSubD
DIR /s /b *.mdl > Modelprep.txt
GOTO GetName
:ExcludeSubD
DIR /b *.mdl > Modelprep.txt
GOTO GetName




GOTO GetName
REM Return here if file already exists
:Confirm
ECHO File already exists, overwrite?
SET /p OVER=[y/n]^>
IF "!OVER!"== "y" (
IF EXIST %SPAWNLIST%.txt del %SPAWNLIST%.txt
GOTO WriteFile
) else (
GOTO GetName
)

GOTO GetName
REM Return here if user filename input is blank.
:BadName
ECHO Your spawnlist filename cannot be blank.
:GetName
REM Get name from user.
ECHO What is your spawnlist going to be named?
SET /P SPAWNLIST=Spawnlist Name: %=%
REM Prompt if name is blank.
IF "%SPAWNLIST%"=="" GOTO BadName
REM Prompt if filename exists.
IF EXIST %SPAWNLIST%.txt GOTO Confirm

:WriteFile
ECHO Beginning list creation...
REM Format Header Info:
ECHO "SpawnMenu" >> %SPAWNLIST%.txt
ECHO {  >> %SPAWNLIST%.txt
ECHO 	"Information"  >> %SPAWNLIST%.txt
ECHO		{  >> %SPAWNLIST%.txt
ECHO 		"version"	"2"  >> %SPAWNLIST%.txt
ECHO 		"name"		"%SPAWNLIST%"   >> %SPAWNLIST%.txt
ECHO		}   >> %SPAWNLIST%.txt
ECHO 	"Entries"   >> %SPAWNLIST%.txt
ECHO 	{   >> %SPAWNLIST%.txt

REM Main loop to find all .mdl files in subdirectories and write them to the named file by number.
FOR /f "delims= tokens=*" %%a in ('find /v "" ^<modelprep.txt') do (
SET modelpath=%%a
CALL :RunReplace
)

IF "%count%"=="" (
ECHO No models found, create empty spawnlist?
SET /p CreateEmpty=[y/n]^>
IF "!CreateEmpty!"== "y" (
ECHO Finishing empty list.
GOTO Continue
) else (
ECHO Aborting.
IF EXIST modelprep.txt del modelprep.txt
IF EXIST %SPAWNLIST%.txt del %SPAWNLIST%.txt
PAUSE
EXIT
)
)
ECHO List complete, found %count% model(s).
:Continue
REM Close brackets in spawnlist.
ECHO 	} >> %SPAWNLIST%.txt
ECHO } >> %SPAWNLIST%.txt

REM Clean up temp file if exists.
IF EXIST modelprep.txt del modelprep.txt
ECHO Your list is located at %CD%\%SPAWNLIST%.txt
REM Allow user to confirm exit.
PAUSE
EXIT

REM Loop assistant subroutine 
:RunReplace
 SET modelpath=!modelpath:%TempDIR%=models!
 SET modelpath=!modelpath:\=/!
 SET /a count+=1
 ECHO 		"%count%"		"%modelpath%" >> %SPAWNLIST%.txt