#!/bin/bash

# Working directory
directory=$(pwd)

# Get usarname
user=$(whoami)

# Colors
Black='\033[1;30m'
Red='\033[1;31m'
Green='\033[1;32m'
Yellow='\033[1;33m'
Blue='\033[1;34m'
Purple='\033[1;35m'
Cyan='\033[1;36m'
White='\033[1;37m'
NC='\033[0m'
blue='\033[0;34m'
white='\033[0;37m'
lred='\033[0;31m'

# Check root
        if [ $(id -u) -ne 0 ]; then
        echo -e "${Blue} You must be root user to run the script"
exit

fi

# Presentation of the script
banner () {
echo -e "${Blue}       ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗                                        "
echo -e "${Blue}      ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝                                        "
echo -e "${Blue}      ██║  ███╗███████║██║   ██║███████╗   ██║         ${White}By ${Blue}AlvinPix        "
echo -e "${Blue}      ██║   ██║██╔══██║██║   ██║╚════██║   ██║                                           "
echo -e "${Blue}  The ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   Installer                               "
echo -e "${Blue}       ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝                                           "
}

check_dependencies () {
echo ""
if which msfconsole >/dev/null; then
	sleep 1
	echo -e "${White} metasploit-framework ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} metasploit-framework ${Red}(not installed)"
	echo ""
        echo -e "${White} metasploit-framework ${Blue}(installing)${White}..."
	echo ""
	apt install metasploit-framework -y
	msfdb init && msfconsole
	echo ""
fi

if which macchanger >/dev/null; then
	sleep 1
	echo -e "${White} macchanger ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} macchanger ${Red}(not installed)"
	echo ""
	echo -e "${White} macchanger ${Blue}(installing)${White}..."
	echo ""
	apt install macchanger -y
	echo ""
fi

if which rkhunter >/dev/null; then
	sleep 1
	echo -e "${White} rkhunter ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} rkhunter ${Red}(not installed)"
	echo ""
	echo -e "${White} rkhunter ${Blue}(installing)${White}..."
	echo ""
	apt install rkhunter -y
	echo ""
fi

if which apache2 >/dev/null; then
	sleep 1
	echo -e "${White} apache2 ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} apache2 ${Red}(not installed)"
	echo ""
	echo -e "${White} apache2 ${Blue}(installing)${White}..."
	echo ""
	apt install apache2 -y
	echo ""
fi

if which zipalign >/dev/null; then
	sleep 1
	echo -e "${White} zipalign ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} zipalign ${Red}(not installed)"
	echo ""
	echo -e "${White} zipalign ${Blue}(installing)${White}..."
	apt install zipalign -y
	echo ""
fi

if which apksigner >/dev/null; then
	sleep 1
	echo -e "${White} apksigner ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} apksigner ${Red}(not installed)"
	echo ""
	echo -e "${White} apksigner ${Blue}(installing)${White}..."
	apt install apksigner -y
	echo ""
fi

if which apktool >/dev/null; then
	sleep 1
	echo -e "${White} apktool ${Blue}(installed)"
else
	echo -e "${White} apktool ${Red}(not installed)"
	echo ""
	echo -e "${White} apktool ${Blue}(installing)${White}..."
	echo ""
	curl https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool >apktool
	wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.7.0.jar
	mv apktool_2.7.0.jar apktool.jar
	chmod +x apktool apktool.jar
	mv apktool apktool.jar /usr/bin
	echo ""
fi

if which netdiscover >/dev/null; then
	sleep 1
	echo -e "${White} netdiscover ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} netdiscover ${Red}(not installed)"
	echo ""
	echo -e "${White} netdiscover ${Blue}(installing)${White}..."
	apt install netdiscover -y
	echo ""
fi

if which wifite >/dev/null; then
	sleep 1
	echo -e "${White} wifite ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} wifite ${Red}(not installed)"
	echo ""
	echo -e "${White} wifite ${Blue}(installing)${White}..."
	apt install wifite -y
	echo ""
fi

if which airgeddon >/dev/null; then
	sleep 1
	echo -e "${White} airgeddon ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} airgeddon ${Red}(not installed)"
	echo ""
	echo -e "${White} airgeddon ${Blue}(installing)${White}..."
	apt install airgeddon -y
	echo ""
fi

if which lsd >/dev/null; then
	sleep 1
	echo -e "${White} lsd ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} lsd ${Red}(not installed)"
	echo ""
	echo -e "${White} lsd ${Blue}(installing)${White}..."
	apt install lsd -y
	echo ""
fi

if which default-jdk >/dev/null; then
	sleep 1
	echo -e "${White} default-jdk ${Blue}(installed)"
else
	sleep 1
	echo -e "${White} default-jdk ${Red}(not installed)"
	echo ""
	echo -e "${White} default-jdk ${Blue}(installing)${White}..."
	apt install default-jdk -y
	echo ""
fi	
	echo ""
	echo -e "${White} All dependencies are satisfied"
	echo ""
	echo -e "${White} You want to create a shortcut command ${Blue}Y/N"
	echo ""
	echo -ne "${White} Ghost > ${Yellow}"
	read shortcut
	echo ""
if [ $shortcut = Y ]; then
	sleep 1
	cd /home/${user}
	echo alias Ghostscript="bash $directory/Ghost.sh" >> .zshrc
else
	exit 
fi
}

# Call menus
reset
banner
check_dependencies
