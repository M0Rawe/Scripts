#!/bin/zsh

PI_DEFAULT="192.168.1.90"
PI_IP="$PI_DEFAULT"

# Define an alias to SSH into the Raspberry Pi
alias pi='ssh pi@raspberrypi'

# Function to SCP a file to the Raspberry Pi
function pipush {
    # Check if at least one argument is provided
    if [[ $# -lt 1 ]]; then
        echo "Usage: pipush /path/to/file.extension [/path/on/the/pi (defaults to /tmp)]"
        return 1
    fi

    # Check if the file exists
    if [[ ! -e $1 ]]; then
        echo "File not found: $1"
        return 1
    fi

    # Set default output path to /tmp if not provided
    out_path="/tmp"
    if [[ $# -gt 1 && -n "$2" ]]; then   
        out_path="$2"
    fi

    # Prompt for confirmation
    read "yn?scp $1 to $PI_IP:~$out_path : (y/n) "
    case $yn in 
        [Yy]*) echo "Copying"
               ;;
        [Nn]*) return 1
               ;;
        * )    echo "Please answer y/n"
               return 1
               ;;
    esac

    # Execute the SCP command
    scp "$1" "pi@$PI_IP:~$out_path"
    return 0
}
