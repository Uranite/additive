@echo off
setlocal

if "%1" == "" goto update
if "%1" == "update-packwiz" goto update-packwiz
if "%1" == "export" goto export
if "%1" == "update" goto update
if "%1" == "update-loader" goto update-loader
if "%1" == "refresh" goto refresh
goto end

:update-packwiz
	go install github.com/packwiz/packwiz@latest
	go install github.com/Merith-TK/packwiz-wrapper/cmd/pw@main
	::cls
	echo Packwiz has been Updated
	goto end

:export
	if not exist build\fabric\ mkdir build\fabric\
	::for /d %%d in (versions\fabric\*) do (
	::    cd %%d
	::    pw mr export
	::    cd ..\..\..
	::)
	cd versions\fabric\1.21.1 && pw mr export
	cd ..\..\..
	::for /R versions\fabric %%f in (*.mrpack) do move "%%f" build\fabric\
	move versions\fabric\1.21.1\*.mrpack build\fabric
	goto end

:update
	::for /d %%d in (versions\fabric\*) do (
	::    cd %%d
	::    pw update --all
	::    cd ..\..\..
	::)
	cd versions\fabric\1.21.1 && pw update --all
	goto end

:update-loader
	::for /d %%d in (versions\fabric\*) do (
	::    cd %%d
	::    pw migrate loader latest
	::    cd ..\..\..
	::)
	cd versions\fabric\1.21.1 && pw migrate loader latest
	goto end

:refresh
	::for /d %%d in (versions\fabric\*) do (
	::    cd %%d
	::    pw refresh
	::    cd ..\..\..
	::)
	cd versions\fabric\1.21.1 && pw refresh
	goto end

:end
endlocal
