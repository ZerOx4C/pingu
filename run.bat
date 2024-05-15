@echo off

type nul > status.log

:head

ping -n 1 %1 | findstr TTL > nul

set DATETIME=%date% %time%

if errorlevel 1 (
	set STAT=NG
) else (
	set STAT=OK
)

if %STAT% == OK (
	echo [92m%DATETIME% %STAT%[0m
) else (
	echo [91m%DATETIME% %STAT%[0m
)

echo %DATETIME% %STAT% >> status.log

timeout /t 60 /nobreak > nul

goto :head
