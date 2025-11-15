REM Start a container that executes the Jupyter notebook (default command)
REM The text must be cut and paste in the navigator and the terminal must
REM not be closed as the session is interactive (-it) and not detached (-d)

cd /D "%~dp0"
call config.cmd

REM Clean-up
call docker_clean_up.bat

docker run -it --rm  ^
    -p %DOCKER_JUPYTER_PORT%:8888 ^
    -v %~dp0\data:/work/data ^
    -v %~dp0\src:/work/src ^
    --name %CONTAINER_NAME% %IMAGE_NAME%

timeout /t 10
