REM Clean-up the container %CONTAINER_NAME%

@echo off
cd /D "%~dp0"
call config.cmd

docker system prune -f
for /F %%c in ('docker ps -a --filter "ancestor=%CONTAINER_NAME%" -q') do (docker stop %%c)
for /F %%c in ('docker ps -a --filter "name=%CONTAINER_NAME%" -q') do (docker stop %%c)
for /F %%c in ('docker ps -a --filter "ancestor=%CONTAINER_NAME%" -q') do (docker rm %%c)
for /F %%c in ('docker ps -a --filter "name=%CONTAINER_NAME%" -q') do (docker rm %%c)

for /f "tokens=2,5" %%A in ('netstat -ano -p tcp') do (
    if not "%%B" == "0" (
        echo %%A > port.tmp
        findstr :%DOCKER_JUPYTER_PORT% port.tmp >nul 2>&1 
        if not errorlevel 1 taskkill /f /pid %%B
        del port.tmp
    )
)

timeout /t 1
