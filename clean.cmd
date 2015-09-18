@echo off

if exist build (
	echo remove directory: build
	rd /s /q build
)

if exist bin (
	echo remove directory: bin
	rd /s /q bin
)

if exist lib (
	echo remove directory: lib
	rd /s /q lib
)

if exist include (
	echo remove directory: include
	rd /s /q include
)

pause