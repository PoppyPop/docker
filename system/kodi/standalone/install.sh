#!/bin/bash
#

sudo add-apt-repository ppa:team-xbmc/ppa
sudo apt-get update

sudo apt install kodi xinit dbus-x11

# sudo apt install i965-va-driver-shaders

#needed to get alsa (sound) and proper graphics card drivers to be seen/used by kodi.
usermod -a -G audio,video kodi
usermod -a -G audio,video, dialout media

#set these two options for xwrapper else wont start.
echo -e "allowed_users=anybody\nneeds_root_rights=yes" >> /etc/X11/Xwrapper.config


cp -f kodi.service /etc/systemd/system/kodi.service

systemctl enable kodi

cat > /etc/polkit-1/localauthority/50-local.d/kodi.pkla <<- EOF
[kodi user]
Identity=unix-user:media
Action=org.freedesktop.login1.*
ResultAny=yes
ResultInactive=no
ResultActive=yes
EOF

