  
#!/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

[[ $(id -u) != 0 ]] && echo -e "\n 哎呀……请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1


apt-get update
apt-get -q -y --force-yes install tightvncserver xterm jwm mercurial libasound2-dev libcurl4-openssl-dev libnotify-dev libxt-dev libiw-dev mesa-common-dev autoconf2.13 yasm libidl-dev screen unzip bzip2 nano xorg lxde-core firefox-esr
wget https://raw.githubusercontent.com/5aimiku/ebesucher-for-debian/master/vncxstartup.txt https://raw.githubusercontent.com/5aimiku/ebesucher-for-debian/master/vncserverinit.txt
mv firefox/ /usr/local/lib/
ln -s /usr/local/lib/firefox/firefox /usr/bin/firefox
vncserver
rm -f ~/.vnc/xstartup
mv vncxstartup.txt ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup
mv vncserverinit.txt /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
update-rc.d vncserver defaults
