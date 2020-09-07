#!/bin/bash
# author: Jiacheng Zhao

zh_cn=("请输入播流m3u8地址：" "是你的播流m3u8地址，对吗？ [Y/N]" "输入错误，请重试！" "请输入B站的推流地址（“开播设置”中的“你的rtmp地址”和“你的直播码”组合成的链接）：" "是你的B站推流地址，对吗？[Y/N]" "网络或者链接异常，正在重试。重试次数：" "监测到你已有连续4次推流失败，当前是否需要取消推流？[Y/N]")

en_us=("Please input the m3u8 address you have to play the live:" "is the m3u8 address you have to play the live, right? [Y/N]" "Input error, please try again!" "Please input your bilibili live room's streaming address(your rtmp address+live auth code):" "is your bilibili live room's streaming address, right? [Y/N]" "Internet or link error, retrying... Retry time(s): " "It has been detected that you have failed to push stream 4 times in a row. Do you need to cancel the push stream now? [Y/N]")

while true
do
    echo "1. 简体中文"
    echo "2. English(US)"
    echo "请选择程序语言："
    read  -p "Please select the program's language:" selection
    case ${selection} in
        1)
            language=("${zh_cn[@]}")
            break;;
        2)
            language=("${en_us[@]}")
            break;;
        *)
            echo "输入错误，请重试！"
            echo "Input error, please try again!";;
    esac
done

while true
do
    read -p ${language[0]} m3u8_address
    printf "\"${m3u8_address}\""
    read -p "${language[1]}" selection
    case ${selection} in
        Y | y)
            break;;
        N | n)
            echo "";;
        *)
            echo ${language[2]};;
    esac
done

while true
do
    read -p ${language[3]} bilibili_address
    printf "\"${bilibili_address}\""
    read -p "${language[4]}" selection
    case ${selection} in
        Y | y)
            break;;
        N | n)
            echo "";;
        *)
            echo ${language[2]};;
    esac
done

error_time=0
while true
do 
    ./ffmpeg -i "${m3u8_address}" -vcodec copy -acodec aac -f flv "${bilibili_address}"
    error_time=`expr ${error_time} + 1`
    if [${error_time} -lt 4]
    then
        printf "${language[5]}${error_time}"
    else
        while true
        do
            read -p "${language[6]}" selection
            case ${selection} in
                Y | y)
                    exit 0;;
                N | n)
                    error_time=0
                    break;;
                *)
                    echo ${language[2]};;
            esac
        done
    fi
done