#!/bin/bash

PI_DEFAULT=192.168.1.199

PI_IP=$PI_DEFAULT

alias pi='ssh pi@raspberrypi'

function pipush {
    if [[ $# -lt 1 ]]; then
        echo "Usage: pipush /path/to/file.extension [/path/on/the/pi (defaults to /tmp)]"
        return 1
    fi
    if [[ ! -e $1 ]]; then
        echo "File not found: $1"
        return 1
    fi
    out_path=/tmp
    if [[ $# -gt 1 && -n "$2" ]]; then   
        out_path=$2
    fi
    read -p "scp $1 to $PI_IP:~$out_path : (y/n)" yn
    case $yn in 
        [Yy]) echo "Copying"
            ;;
        [Nn]) return 1;;
        * ) echo "Please answer y/n"; return 1;;
    esac
    scp $1 pi@raspberrypi:~$out_path
    return 0;
}   