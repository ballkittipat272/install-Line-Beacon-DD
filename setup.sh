#!/bin/bash
echo "********Enter hardwareId carefully (IT CAN'T CHANGE IF YOU MISTAKE)********" 
read hardwareId
#Setup Raspberry Pi to Line Beacon
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
#make sh file for autorun Line Beacon
mkdir /home/pi/startup
cd /home/pi/startup
touch startup.sh
set +H
echo " #!/bin/bash" >> startup.sh
echo "cd /home/pi/line-simple-beacon/tools/line-simplebeacon-nodejs-sample/" >> startup.sh
echo "sudo ./simplebeacon.js --hwid=$hardwareId" >> startup.sh
chmod 755 /home/pi/startup/startup.sh
set -H
cd /etc
sudo sed -i 's+fi+fi\n/home/pi/startup/startup.sh+' rc.local
sudo reboot
