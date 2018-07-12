
sudo mkdir -p /datas/tvheadend

if id "dvb-video" >/dev/null 2>&1; then
        echo "user exists"
else
        sudo useradd dvb-video -r --shell /bin/false
fi

sudo chown -R dvb-video:dvb-video /datas/tvheadend/

# sudo usermod -a -G video dvb-video

#Frequences
#690000000
#626000000
#650000000
#482000000
#506000000
#714000000

# Icons
# Url : file:///picons/%C.png
# Schema : lower case
#