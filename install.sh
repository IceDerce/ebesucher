#!/bin/bash

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'

[[ $(id -u) != 0 ]] && echo -e "\n 哎呀……请使用 ${red}root ${none}用户运行 ${yellow}~(^_^) ${none}\n" && exit 1

apt-get update
apt-get -y install xorg lxde-core tightvncserver
wget https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncserverinit.txt \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncxstartup.txt \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/firefox.desktop \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/profiles.ini \
https://raw.githubusercontent.com/IceDerce/ebesucher/master/firefox-set.tar.gz


tightvncserver :1  2>&1
tightvncserver -kill :1  
rm -f ~/.vnc/xstartup
mv vncxstartup.txt ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup


mv vncserverinit.txt /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
update-rc.d vncserver defaults
tightvncserver :1

mv firefox.desktop /usr/share/applications/

wget http://ftp.mozilla.org/pub/firefox/releases/51.0/linux-x86_64/en-US/firefox-51.0.tar.bz2
tar xjf firefox-51.0.tar.bz2
mv firefox/ /usr/local/lib/
ln -s /usr/local/lib/firefox/firefox /usr/bin/firefox
firefox
killall firefox

tar -zvxf firefox-set.tar.gz
rm -r .mozilla/firefox/profiles.ini
mv modified.default .mozilla/firefox
mv profiles.ini .mozilla/firefox

