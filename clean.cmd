@echo off

if exist build (
	echo remove directory: build
	rd /s /q build
)

if exist putput (
	echo remove directory: bin
	rd /s /q bin
)

pause
