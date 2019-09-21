#/bin/bash
#

sudo usermod -a -G cdrom,video,plugdev,users,input,netdev,audio media

ver=$(lsb_release -sr); if [ $ver != "17.10" -a $ver != "17.04" -a $ver != "16.04" ]; then ver=16.04; fi 
echo "deb http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q http://download.opensuse.org/repositories/home:/strycore/xUbuntu_$ver/Release.key -O- | sudo apt-key add -


sudo add-apt-repository multiverse

sudo apt-get install kodi kodi-peripheral-joystick lutris steam midori lightdm

wget -O kodi-openbox-master.zip https://github.com/lufinkey/kodi-openbox/archive/master.zip

unzip kodi-openbox-master.zip

cd kodi-openbox-master

./build.sh

sudo dpkg -i kodi-openbox.deb

sudo apt-get -f install

cd ..

rm -r kodi-openbox-master kodi-openbox-master.zip