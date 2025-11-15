REM Construction of the image %IMAGE_NAME%

cd /D "%~dp0"
call config.cmd

docker build -t %IMAGE_NAME% -f %~dp0\Dockerfile .

REM Few seconds to read messages...
timeout /t 30
