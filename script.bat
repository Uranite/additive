@echo off

if "%1" == "" goto update
if "%1" == "update-packwiz" goto update-packwiz
if "%1" == "export" goto export
if "%1" == "update" goto update
if "%1" == "update-loader" goto update-loader
if "%1" == "refresh" goto refresh
if "%1" == "add" goto add
goto end

:update-packwiz
	go install github.com/packwiz/packwiz@latest
	::cls
	echo Packwiz has been Updated
	goto end

:export
	if not exist build\fabric\ mkdir build\fabric\
	::for /d %%d in (archived\fabric\*) do (
	::    cd %%d
	::    packwiz mr export
	::    cd ..\..\..
	::)
	cd archived\fabric\1.18.2 && packwiz mr export
	cd ..\..\..
	::for /R archived\fabric %%f in (*.mrpack) do move "%%f" build\fabric\
	move archived\fabric\1.18.2\*.mrpack build\fabric
	goto end

:update
	::for /d %%d in (archived\fabric\*) do (
	::    cd %%d
	::    packwiz update --all
	::    cd ..\..\..
	::)
	cd archived\fabric\1.18.2 && packwiz update --all
	goto end

:update-loader
	::for /d %%d in (archived\fabric\*) do (
	::    cd %%d
	::    packwiz migrate loader latest
	::    cd ..\..\..
	::)
	cd archived\fabric\1.18.2 && packwiz migrate loader latest
	goto end

:refresh
	for /d %%d in (archived\fabric\*) do (
	    cd %%d
	    packwiz refresh
	    cd ..\..\..
	)
	goto end

:add
	::for /d %%d in (archived\fabric\*) do (
	::    cd %%d
	::    packwiz refresh
	::    cd ..\..\..
	::)
	cd archived\fabric\1.18.2 && packwiz mr add "%2"
	goto end

:end
