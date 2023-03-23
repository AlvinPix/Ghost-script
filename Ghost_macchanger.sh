#!/bin/bash

# MACCHANGER

# GNU MAC Changer es una utilidad que facilita la manipulación de las direcciones MAC de las interfaces de red.
# Las direcciones MAC son identificadores únicos en las redes, solo necesitan ser únicos, se pueden cambiar en la
# Mayoría del hardware de red. Las direcciones MAC han comenzado a ser abusadas por empresas de marketing
# Sin escrúpulos, agencias gubernamentales y otros para proporcionar una manera fácil de rastrear una
# Computadora a través de múltiples redes. Al cambiar la dirección MAC con regularidad, este tipo de seguimiento
# Se puede frustrar o, al menos, dificultar mucho más.

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
        echo -e "${Blue} You must first run the Ghost script"
exit

fi

# Presentation of the script
banner () {
echo -e "${Blue}       ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗                                        "
echo -e "${Blue}      ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝                                        "
echo -e "${Blue}      ██║  ███╗███████║██║   ██║███████╗   ██║         ${White}By ${Blue}AlvinPix        "
echo -e "${Blue}      ██║   ██║██╔══██║██║   ██║╚════██║   ██║                                           "
echo -e "${Blue}  The ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   Macchanger                              "
echo -e "${Blue}       ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝                                           "
}

# The main manu
usage_macchanger () {
clear
echo ""
banner
echo ""
echo -e "${White} [${Yellow}0${White}] Return to main menu"
echo -e "${White} [${Yellow}1${White}] Print the MAC"
echo -e "${White} [${Yellow}2${White}] Random MAC"
echo -e "${White} [${Yellow}3${White}] Permanent MAC"
echo -e "${White} [${Yellow}4${White}] Custom MAC"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read macghostchange

case $macghostchange in

0)
cd $directory
./Ghost.sh
usage_macchanger ;;

1)
echo ""
echo -e "${White} Write the name of the interface${Blue}"
echo ""
iwconfig
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read interfacename
echo ""
macchanger -s $interfacename
echo ""
echo -ne "${White} Press any key to continue..."
read
usage_macchanger ;;

2)
echo ""
echo -e "${White} Write the name of the interface${Blue}"
echo ""
iwconfig
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read ramdoninterfacemac
echo ""
ip link set $ramdoninterfacemac down
macchanger -r $ramdoninterfacemac
ip link set $ramdoninterfacemac up
echo ""
echo -ne "${White} Press any key to continue..."
read
usage_macchanger ;;

3)
echo ""
echo -e "${White} Write the name of the interface${Blue}"
echo ""
iwconfig
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read Permamac
echo ""
ip link set $Permamac down
macchanger -p $Permamac
ip link set $Permamac up
echo ""
echo -ne "${White} Press any key to continue..."
read
usage_macchanger ;;

4)
echo ""
echo -e "${White} Write the name of the interface${Blue}"
echo ""
iwconfig
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read intercah
echo ""
echo -e "${White} Write the MAC address"
echo ""
echo -e "${White} MAC ${Blue}(XX:XX:XX:XX:XX:XX)"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read macgustds
echo ""
ip link set $intercah down
macchanger -m $macgustds $intercah
ip link set $intercah up
echo ""
echo -ne "${White} Press any key to continue..."
read
usage_macchanger ;;

* )
echo -e "${Blue} The option is not valid please choose a number"
sleep 1
usage_macchanger ;;
esac
}

# Call the main menu ghost-macchanger
reset
usage_macchanger
