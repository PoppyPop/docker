#/bin/bash
#

mkdir -p ~/.config/openbox

cp /etc/xdg/openbox/autostart ~/.config/openbox/

echo "
	# Set keyboard layout
	setxkbmap -layout fr
	
	# black screen
	xsetroot -solid '#000000'
	" >> ~/.config/openbox/autostart
	
wget https://github.com/SpiralCut/plugin.program.advanced.launcher/archive/master.zip

#https://github.com/lufinkey/kodi-openbox
#https://forum.kodi.tv/showthread.php?tid=282593
