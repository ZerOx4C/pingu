@echo off

set LOGNAME=%date%_%time%
set LOGNAME=%LOGNAME:/=%
set LOGNAME=%LOGNAME::=%
set LOGNAME=%LOGNAME:.=%
set LOGNAME=%LOGNAME%.log

set IPADDR=%1

echo %IPADDR% > %LOGNAME%

:head

ping -n 1 %IPADDR% | findstr TTL > nul

set DATETIME=%date% %time%

if errorlevel 1 (
	set STAT=NG!
) else (
	set STAT=OK
)

if %STAT% == OK (
	echo [92m%DATETIME% %STAT%[0m
) else (
	echo [91m%DATETIME% %STAT%[0m
)

echo %DATETIME% %STAT% >> %LOGNAME%

timeout /t 60 /nobreak > nul

goto :head
