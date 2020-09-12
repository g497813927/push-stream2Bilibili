@echo off
title 直播推送设置
cls

:m3u8_address_setting
set /p m3u8_address=请输入播流m3u8地址：
goto m3u8_address_confirm

:m3u8_address_confirm
echo "%m3u8_address%"
set /p selection=是你的播流m3u8地址，对吗？ [Y/N]
if "%selection%"=="Y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="N" (
    goto m3u8_address_setting
) else if "%selection%"=="n" (
    goto m3u8_address_setting
) else (
    echo 输入错误，请重试！
    echo.
    goto m3u8_address_confirm
)

:bilibili_stream_address_setting
set /p bilibili_address=请输入B站的推流地址（“开播设置”中的“你的rtmp地址”和“你的直播码”组合成的链接）：
goto bilibili_address_confirm

:bilibili_address_confirm
echo "%bilibili_address%"
set /p selection=是你的B站推流地址，对吗？[Y/N]
if "%selection%"=="Y" (
    goto streaming
) else if "%selection%"=="y" (
    goto streaming
) else if "%selection%"=="N" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="n" (
    goto bilibili_stream_address_setting
) else (
    echo 输入错误，请重试！
    echo.
    goto bilibili_address_confirm
)

set error_time=0
:streaming
title 正在推流……
%cd%\ffmpeg.exe -i %m3u8_address% -vcodec copy -acodec aac -f flv %bilibili_address%
set /a error_time=%error_time%+1
if %error_time% lss 4 (
    echo 网络或者链接异常，正在重试。重试次数：%error_time%
    goto streaming
) else (
    goto alert
)

:alert
set /p selection=监测到你已有连续4次推流失败，是否需要取消推流？[Y/N]
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
    echo 输入错误，请重试！
    echo.
    goto alert
)
