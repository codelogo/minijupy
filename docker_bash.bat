REM Start a bash interactive container named %CONTAINER_NAME%

cd /D "%~dp0"
call config.cmd

REM Clean-up
call docker_clean_up.bat

start docker run -it --rm ^
      -v %~dp0\src:/work/src ^
      -v %~dp0\data:/work/data ^
      --name %CONTAINER_NAME% %IMAGE_NAME% ^
      /usr/bin/bash

timeout /t 10