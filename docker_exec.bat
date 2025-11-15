REM Enter a running container

cd /D "%~dp0"
call config.cmd

start docker exec -it %CONTAINER_NAME% bash

timeout /t 10