#!/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'

[[ $(id -u) != 0 ]] && echo -e "\n 哎呀……请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1

apt-get update
apt-get -y install xorg lxde-core tightvncserver libgtk3.0-cil-dev xterm jwm mercurial libasound2-dev libcurl4-openssl-dev libnotify-dev libxt-dev libiw-dev mesa-common-dev autoconf2.13 yasm libidl-dev screen

mkdir ./tmp/ && cd tmp/
wget https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncserverinit.txt \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncxstartup.txt \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/firefox.desktop 

tightvncserver :1  2>&1
tightvncserver -kill :1  
rm -f ~/.vnc/xstartup
mv vncxstartup.txt ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

mv vncserverinit.txt /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
update-rc.d vncserver defaults
mv firefox.desktop /usr/share/applications/

tightvncserver :1


wget http://ftp.mozilla.org/pub/firefox/releases/51.0/linux-x86_64/en-US/firefox-51.0.tar.bz2
tar xjf firefox-51.0.tar.bz2
mv firefox/ /usr/local/lib/
ln -s /usr/local/lib/firefox/firefox /usr/bin/firefox
#firefox --no-remote
#sleep 3
#killall firefox

#wget https://raw.githubusercontent.com/IceDerce/ebesucher/master/profiles.ini \
#https://raw.githubusercontent.com/IceDerce/ebesucher/master/firefox-set.tar.gz
tar -zvxf firefox-set.tar.gz
rm -rf /root/.mozilla/firefox/profiles.ini
mv modified.default /root/.mozilla/firefox
mv profiles.ini /root/.mozilla/firefox

rm -rf /root/tmp/
