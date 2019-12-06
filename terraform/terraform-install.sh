#!/bin/bash

# run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\nYou must be a root user\n"
    exit 1
else

    CACHEDIR="/tmp/terraform";
    sudo mkdir -p "$CACHEDIR"
    cd "$CACHEDIR"

    version="$(wget -qO- "https://releases.hashicorp.com/terraform/" -O -| grep -o "terraform/[0-9.]*" | head -n 1)"

    URL="https://releases.hashicorp.com/$version/"

    FILE=$(wget "https://releases.hashicorp.com/$version/" -O -| grep -o "terraform_[0-9.]*_linux_amd64.zip" | head -n 1)
  
    wget -c "$URL$FILE"

    if [[ ! -f "$FILE" ]]; then                   
        exit 1
    fi

    unzip "$FILE" -d "/usr/local/bin/"
fi
