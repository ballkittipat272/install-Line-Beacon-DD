#!/bin/bash
echo "********Enter hardwareId carefully********" 
read hardwareId
cd /home/pi/
sudo apt-get install bluetooth bluez libbluetooth-dev libudev-dev
wget https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-armv6l.tar.xz
tar -xvf node-v8.11.3-linux-armv6l.tar.xz
cd node-v8.11.3-linux-armv6l
sudo cp -R * /usr/local/
cd /home/pi/
sudo apt-get install nodejs
sudo apt-get install npm
git clone https://github.com/line/line-simple-beacon.git
cd line-simple-beacon/tools/line-simplebeacon-nodejs-sample/
npm install
cd /home/pi/bin
touch startup.sh
set +H
echo " #!/bin/bash" >> startup.sh
echo "cd /home/pi/line-simple-beacon/tools/line-simplebeacon-nodejs-sample/" >> startup.sh
echo "sudo ./simplebeacon.js --hwid=$hardwareId" >> startup.sh
set -H
cd /etc
sed -i 's+exit 0+/home/pi/startup.sh\nexit 0+' rc.local
sudo reboot
 