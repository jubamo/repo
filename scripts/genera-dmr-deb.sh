#!/usr/bin/env bash

cd /var/lib/openwebrx

mkdir owrx.deb
cd owrx.deb

apt update
apt upgrade
apt install -y git wget gpg debhelper cmake libprotobuf-dev protobuf-compiler

wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | gpg --dearmor -o /usr/share/keyrings/openwebrx.gpg
echo "deb [signed-by=/usr/share/keyrings/openwebrx.gpg] https://repo.openwebrx.de/debian/ bullseye main" > /etc/apt/sources.list.d/openwebrx.list
apt-get update
apt install -y libcodecserver-dev openwebrx

git clone https://github.com/szechyjs/mbelib.git
cd mbelib
dpkg-buildpackage -us -uc
cd ..
dpkg -i  libmbe-dev_1.3.0_*.deb libmbe1_1.3.0_*.deb

git clone https://github.com/knatterfunker/codecserver-softmbe.git
cd codecserver-softmbe
dpkg-buildpackage -us -uc
cd ..
dpkg -i codecserver-driver-softmbe_0.0.1_*.deb

echo "  " >> /etc/codecserver/codecserver.conf
echo "[device:softmbe]" >> /etc/codecserver/codecserver.conf
echo "driver=softmbe" >> /etc/codecserver/codecserver.conf
