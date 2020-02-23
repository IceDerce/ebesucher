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
wget https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncserverinit.txt https://raw.githubusercontent.com/IceDerce/ebesucher/master/vncxstartup.txt https://raw.githubusercontent.com/IceDerce/ebesucher/master/firefox.desktop


tightvncserver :1  2>&1
rm -f ~/.vnc/xstartup
mv vncxstartup.txt ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

mv vncserverinit.txt /etc/init.d/vncserver
chmod +x /etc/init.d/vncserver
update-rc.d vncserver defaults

mv firefox.desktop /usr/share/applications/

wget https://objectstorage.ap-tokyo-1.oraclecloud.com/n/nrjcs6lwr9vy/b/tokyo-oracle-10gb/o/ebesucherfirefox-51-addon.modified.tar.gz
tar -zvxf ebesucherfirefox-51-addon.modified.tar.gz ./firefox/
mv firefox/ /usr/local/lib/
ln -s /usr/local/lib/firefox/firefox /usr/bin/firefox
