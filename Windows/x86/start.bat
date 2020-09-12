@echo off
title Language Select

:language_select
echo 1. 简体中文
echo 2. English(US)
echo 请选择程序语言：
echo Please select the program's language:
set /p lang_select=
if "%lang_select%"=="1" (
    .\lang\zh_cn.bat
) else if "%lang_select%"=="2" (
    .\lang\en_us.bat
) else (
    echo 输入错误！请重试！
    echo Input error, please try again!
    echo.
    goto language_select
)
