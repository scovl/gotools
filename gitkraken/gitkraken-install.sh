#!/bin/bash

# run as root
if [[ $EUID -ne 0 ]]; then
    echo -e "\nYou must be a root user\n"
    exit 1
else

    # What distribution
    lsb_dist="$(. /etc/os-release && echo "$ID")"

    echo -e "\n Install dependencies\n"

    # Fedora
    if [ $lsb_dist == "fedora" ]; then
        sudo dnf -y install "git-all"
    fi

    if [ $lsb_dist == "ubuntu" ]; then
        sudo apt -y install "git-all"
    fi


    CACHEDIR="/tmp/gitkraken";
    sudo mkdir -p "$CACHEDIR"
    cd "$CACHEDIR"

    URL=$(wget -c "https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz")
    FILE=${URL##*/}

    wget -c "$URL" -O "$FILE"

    if [[ ! -f "$FILE" ]]; then
        exit 1
    fi

    sudo tar -xzf "$FILE" -C "/opt/"

    sudo ln -sf "/opt/gitkraken/gitkraken" "/usr/bin/gitkraken"

    xdg-icon-resource install --novendor --size 128 "/opt/gitkraken/gitkraken.png" "gitkraken"
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor

    sudo cat <<EOF | tee /usr/share/applications/gitkraken.desktop
    [Desktop Entry]
    Name=GitKraken
    Type=Application
    Icon=gitkraken
    Exec=gitkraken
    Comment=The Most Intelligent Git client
    Categories=Development;IDE;
    Keywords=Idea;Git;IDE;
    StartupNotify=true
    Terminal=false
    StartupWMClass=Gitkraken
EOF

fi
