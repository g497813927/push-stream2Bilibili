@echo off
title Language Select

:language_select
echo 1. ��������
echo 2. English(US)
echo ��ѡ��������ԣ�
echo Please select the program's language:
set /p lang_select=
if "%lang_select%"=="1" (
    .\lang\zh_cn.bat
) else if "%lang_select%"=="2" (
    .\lang\en_us.bat
) else (
    echo ������������ԣ�
    echo Input error, please try again!
    echo.
    goto language_select
)
