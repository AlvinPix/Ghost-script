#!/bin/bash

# Author: Enríquez González https://github.com/AlvinPix
# instagram: @alvinpx_271
# facebook: @alvin.gonzalez.13139

# Host discovery
lanip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')

# Working directory
directory=$(pwd)

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
echo -e "${Blue}  The ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   Script                                  "
echo -e "${Blue}       ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝                                           "
}

# The main menu
ghostmenu () {
clear
echo ""
banner
echo ""
echo -e "${White} [${Yellow}0${White}] Exit script"
echo ""
echo -e "${White} [${Yellow}it${White}] Metasploit          ${White} [${Yellow}mf${White}] Msfvenom"
echo -e "${White} [${Yellow}ne${White}] Netdiscover         ${White} [${Yellow}ma${White}] Macchanger"
echo -e "${White} [${Yellow}ai${White}] Airgeddon           ${White} [${Yellow}li${White}] Listeners"
echo -e "${White} [${Yellow}wi${White}] Wifite"
echo -e "${White} [${Yellow}rk${White}] Rkhunter"
echo ""
echo -e "${White} [${Yellow}1${White}] Enable ${Blue}bluetooth"
echo -e "${White} [${Yellow}2${White}] Disable ${Blue}bluetooth"
echo -e "${White} [${Yellow}3${White}] Enable ${Blue}apache2"
echo -e "${White} [${Yellow}4${White}] Disable ${Blue}apache2"
echo -e "${White} [${Yellow}5${White}] Start ${Blue}serverpython3"
echo ""
echo -e "${White} [${Yellow}if${White}] Ifconfig"
echo -e "${White} [${Yellow}iw${White}] Iwconfig"
echo -e "${White} [${Yellow}ip${White}] Ipconfig"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read ghostopt

case $ghostopt in

0)
echo -e "${Blue} Shutting down services started by the script"
systemctl stop bluetooth.service 2>/dev/null
systemctl disable bluetooth.service 2>/dev/null
service apache2 stop 2>/dev/null
systemctl stop postgresql 2>/dev/null
echo -e "${Blue} Exiting the script"
exit ;;

it)
echo ""
systemctl start postgresql
systemctl status postgresql
sleep 2
sudo msfdb init && msfconsole
echo ""
systemctl stop postgresql
systemctl status postgresql
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

ne)
clear
netdiscover
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

ai)
clear
airgeddon
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

wi)
clear
wifite
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

rk)
echo ""
rkhunter --check
echo ""
echo -ne "${White} Press any key to continue..."
read
clear
ghostmenu ;;

mf)
cd $directory
./Ghost_msfvenom.sh
ghostmenu ;;

ma)
cd $directory
./Ghost_macchanger.sh
ghostmenu ;;

1)
echo ""
systemctl start bluetooth.service
systemctl enable bluetooth.service
systemctl status bluetooth.service
sleep 2
ghostmenu ;;

2)
echo ""
systemctl disable bluetooth.service
systemctl stop bluetooth.service
systemctl status bluetooth.service
sleep 2
ghostmenu ;;

3)
echo ""
service apache2 start
service apache2 status
sleep 2
ghostmenu ;;

4)
echo ""
service apache2 stop
service apache2 status
sleep 2
ghostmenu ;;

5)
echo ""
echo -e "${White} Server open in the ${Blue}(Generated)${White} folder"
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} Press ${Blue}(Ctrl + C)${White} to stop"
echo ""
cd $directory/Generated && python3 -m http.server 8080
ghostmenu ;;

if)
clear
ifconfig
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

iw)
clear
iwconfig
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

ip)
clear
ip a
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmenu ;;

li)
cd $directory
./Ghost_listeners.sh
ghostmenu ;;

* )
echo -e "${Blue} The option is not valid please choose a number or letters"
sleep 1
ghostmenu ;;
esac
}

# Call menus the script Ghost
reset
ghostmenu
