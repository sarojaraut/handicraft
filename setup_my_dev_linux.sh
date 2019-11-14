#!/bin/bash

# Notes
# Copy the binary files e.g sqlcl-18.4.0.007.1818.zip and 
# sqldeveloper-18.4.0-376.1900-no-jre.zip to the directory
# ../mysoftware/. This script picks from there and completes
# the installation

# my directory structures 
# /home/mybriefcase

#VS Code
# For upgrade sudo apt-get update and sudo apt-get install code
function install_vs_code(){
    echo ".....Installing VS Code"
    sudo apt update
    sudo apt install -y software-properties-common apt-transport-https wget
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
    # Below is required for Install .NET Core SDK on Linux Ubuntu 19.04 - x64 which in tuen is reqired for oracle developer extension
    wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get install apt-transport-https
    sudo apt-get update
    sudo apt-get install dotnet-sdk-2.2
}

#Keybase
function install_keybase(){
    echo ".....Installing keybase"
    curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
    # if you see an error about missing `libappindicator1` from the next
    # command, you can ignore it, as the subsequent command corrects it
    sudo dpkg -i keybase_amd64.deb
    sudo apt install -y -f
    run_keybase -g
}

# Git
function install_git(){
    echo ".....Installing git"
    sudo apt install -y git
    sudo apt-get install xclip
    #ssh-keygen
    # to copy public key xclip -sel clip < ~/.ssh/id_rsa.pub
    # ssh -T git@bitbucket.org
}

# Java
function install_java(){
    echo ".....Installing java"
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
    sudo apt-get update
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
    sudo apt-get install -y oracle-java8-installer
    sudo apt install oracle-java8-set-default
}

# Docker
function install_docker(){
    echo ".....Installing docker"
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
    sudo apt update
    sudo apt install -y docker-ce
    sudo mkdir -p /home/docker/ 
    sudo rm -rf /var/lib/docker
    sudo ln -s -b /home/docker /var/lib/docker

#replace line : ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
#with line  :   ExecStart=/usr/bin/dockerd -g /home/docker -H fd:// --containerd=/run/containerd/containerd.sock
# systemctl stop docker
# systemctl daemon-reload
# systemctl start docker
# sudo mv /var/lib/docker/ /home/docker/ 
# cd /var/lib/docker
# sudo du -s -h .
# sudo ln -s -b /home/docker /var/lib/docker
}

# SQLDeveloper
function install_sqldeveloper(){
    echo ".....Installing SQLDeveloper"
    sudo unzip ../mysoftware/sqldeveloper-18.4.0-376.1900-no-jre.zip -d /opt/
    sudo cp ../mysoftware/sql-server-icon-png-28.png /opt/sqldeveloper/sql-server-icon-png-28.png
    sudo chmod 777 /opt/sqldeveloper/sqldeveloper.sh
    sudo ln -s /opt/sqldeveloper/sqldeveloper.sh /usr/local/bin/sqldeveloper

    echo '#!/bin/bash'                           >  /opt/sqldeveloper/sqldeveloper.sh
    echo 'unset -v GNOME_DESKTOP_SESSION_ID'     >> /opt/sqldeveloper/sqldeveloper.sh
    echo 'cd /opt/sqldeveloper/sqldeveloper/bin' >> /opt/sqldeveloper/sqldeveloper.sh
    echo './sqldeveloper "$@"'                   >> /opt/sqldeveloper/sqldeveloper.sh

    cd /usr/share/applications/

    echo '[Desktop Entry]'                                   >  sqldeveloper.desktop
    echo 'Exec=sqldeveloper'                                 >> sqldeveloper.desktop
    echo 'Terminal=false'                                    >> sqldeveloper.desktop
    echo 'StartupNotify=true'                                >> sqldeveloper.desktop
    echo 'Categories=GNOME;Oracle;'                          >> sqldeveloper.desktop
    echo 'Type=Application'                                  >> sqldeveloper.desktop
    echo 'Icon=/opt/sqldeveloper/sql-server-icon-png-28.png' >> sqldeveloper.desktop
    echo 'Name=Oracle SQL Developer'                         >> sqldeveloper.desktop
}

# mailspring
function install_mainspring(){
    echo ".....Installing mailspring"
    sudo snap install mailspring
}

# preload : monitors and improves app startup speed
function install_preload(){
    echo ".....Installing preload"
    sudo apt install -y preload
}

# gnome-system-monitor
function install_gnome_sysmon(){
    echo ".....Installing sysmon"
    sudo apt install -y gnome-system-monitor
}

# flash player plugin
function install_flash_player(){
    echo ".....Install flash player"
    sudo apt install -y browser-plugin-freshplayer-pepperflash
}

# Insomnia
function install_insomnia(){
    echo ".....Install insomnia"
    sudo snap install insomnia
}

# SQLCL
function install_sqlcl(){
    echo ".....Installing sqlcl"
    sudo unzip ../mysoftware/sqlcl-18.4.0.007.1818.zip -d /opt/
    sudo ln -s /opt/sqlcl/bin/sql /usr/local/bin/sql
}

# Font FiraCode
function install_font_firacode(){
    echo ".....Installing Fira Code Font"
    sudo apt install fonts-firacode
}


# # Name
# function install_git(){
# }

###################################
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
############# MAIN ################
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
###################################

install_vs_code;

install_keybase;

install_git;

install_java;

install_docker;

install_sqldeveloper;

install_mainspring;

install_gnome_sysmon;

install_preload;

install_flash_player;

install_insomnia;

install_font_firacode;
