@echo off
title Stream Setting
cls

:m3u8_address_setting
set /p m3u8_address=Please input the m3u8 address you have to play the live:
goto m3u8_address_confirm

:m3u8_address_confirm
echo "%m3u8_address%"
set /p selection=is the m3u8 address you have to play the live, right? [Y/N]
if "%selection%"=="Y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="N" (
    goto m3u8_address_setting
) else if "%selection%"=="n" (
    goto m3u8_address_setting
) else (
    echo Input error, please try again!
    echo.
    goto m3u8_address_confirm
)

:bilibili_stream_address_setting
set /p bilibili_address=Please input your bilibili live room's streaming address(your rtmp address+live auth code):
goto bilibili_address_confirm

:bilibili_address_confirm
echo "%bilibili_address%"
set /p selection=is your bilibili live room's streaming address, right? [Y/N]
if "%selection%"=="Y" (
    goto streaming
) else if "%selection%"=="y" (
    goto streaming
) else if "%selection%"=="N" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="n" (
    goto bilibili_stream_address_setting
) else (
    echo Input error, please try again!
    echo.
    goto bilibili_address_confirm
)

set error_time=0
:streaming
title Streaming...
%cd%\ffmpeg.exe -i %m3u8_address% -vcodec copy -acodec aac -f flv %bilibili_address%
set /a error_time=%error_time%+1
if %error_time% lss 4 (
    echo Internet or link error, retrying... Retry time(s): %error_time%
    goto streaming
) else (
    goto alert
)

:alert
set /p selection=It has been detected that you have failed to push stream 4 times in a row. Do you need to cancel the push stream now? [Y/N]
if "%selection%"=="Y" (
    exit
) else if "%selection%"=="y" (
    exit
) else if "%selection%"=="N" (
    set /a error_time=0
    goto streaming
) else if "%selection%"=="n" (
    set /a error_time=0
    goto streaming
) else (
    echo Input error, please try again!
    echo.
    goto alert
)
