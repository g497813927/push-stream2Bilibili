@echo off
title ֱ����������
cls

:m3u8_address_setting
set /p m3u8_address=�����벥��m3u8��ַ��
goto m3u8_address_confirm

:m3u8_address_confirm
echo "%m3u8_address%"
set /p selection=����Ĳ���m3u8��ַ������ [Y/N]
if "%selection%"=="Y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="y" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="N" (
    goto m3u8_address_setting
) else if "%selection%"=="n" (
    goto m3u8_address_setting
) else (
    echo ������������ԣ�
    echo.
    goto m3u8_address_confirm
)

:bilibili_stream_address_setting
set /p bilibili_address=������Bվ��������ַ�����������á��еġ����rtmp��ַ���͡����ֱ���롱��ϳɵ����ӣ���
goto bilibili_address_confirm

:bilibili_address_confirm
echo "%bilibili_address%"
set /p selection=�����Bվ������ַ������[Y/N]
if "%selection%"=="Y" (
    goto streaming
) else if "%selection%"=="y" (
    goto streaming
) else if "%selection%"=="N" (
    goto bilibili_stream_address_setting
) else if "%selection%"=="n" (
    goto bilibili_stream_address_setting
) else (
    echo ������������ԣ�
    echo.
    goto bilibili_address_confirm
)

set error_time=0
:streaming
title ������������
%cd%\ffmpeg.exe -i %m3u8_address% -vcodec copy -acodec aac -f flv %bilibili_address%
set /a error_time=%error_time%+1
if %error_time% lss 4 (
    echo ������������쳣���������ԡ����Դ�����%error_time%
    goto streaming
) else (
    goto alert
)

:alert
set /p selection=��⵽����������4������ʧ�ܣ��Ƿ���Ҫȡ��������[Y/N]
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
    echo ������������ԣ�
    echo.
    goto alert
)
