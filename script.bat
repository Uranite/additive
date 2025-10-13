@echo off

if "%1" == "" goto update
if "%1" == "update-packwiz" goto update-packwiz
if "%1" == "export" goto export
if "%1" == "update" goto update
if "%1" == "update-loader" goto update-loader
if "%1" == "refresh" goto refresh
if "%1" == "add" goto add
goto :EOF

:update-packwiz
    go install github.com/packwiz/packwiz@latest
    ::cls
    echo Packwiz has been Updated
    goto :EOF

:export
    if not exist build\fabric\ mkdir build\fabric\
    ::for /d %%d in (versions\fabric\*) do (
    ::    cd %%d
    ::    packwiz mr export
    ::    cd ..\..\..
    ::)
    cd versions\fabric\1.21.8 && packwiz mr export
    cd ..\..\..
    ::for /R versions\fabric %%f in (*.mrpack) do move "%%f" build\fabric\
    move versions\fabric\1.21.8\*.mrpack build\fabric
    goto :EOF

:update
    ::for /d %%d in (versions\fabric\*) do (
    ::    cd %%d
    ::    packwiz update --all
    ::    cd ..\..\..
    ::)
    cd versions\fabric\1.21.8 && packwiz update --all
    goto :EOF

:update-loader
    ::for /d %%d in (versions\fabric\*) do (
    ::    cd %%d
    ::    packwiz migrate loader latest
    ::    cd ..\..\..
    ::)
    cd versions\fabric\1.21.8 && packwiz migrate loader latest
    goto :EOF

:refresh
    for /d %%d in (versions\fabric\*) do (
        cd %%d
        packwiz refresh
        cd ..\..\..
    )
    goto :EOF

:add
    ::for /d %%d in (versions\fabric\*) do (
    ::    cd %%d
    ::    packwiz refresh
    ::    cd ..\..\..
    ::)
    cd versions\fabric\1.21.8 && packwiz mr add "%2"
    goto :EOF
