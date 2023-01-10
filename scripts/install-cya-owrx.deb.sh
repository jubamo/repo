#!/usr/bin/env bash

apt update
apt -y install wget gpg

wget -O - https://jubamo.github.io/repo/KEY.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/KEY.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/KEY.gpg] https://jubamo.github.io/repo/debian/ ./" > /etc/apt/sources.list.d/openwebrx-plus.list


wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | gpg --dearmor -o /usr/share/keyrings/openwebrx.gpg
echo "deb [signed-by=/usr/share/keyrings/openwebrx.gpg] https://repo.openwebrx.de/debian/ bullseye main" > /etc/apt/sources.list.d/openwebrx.list

apt update
apt -y install openwebrx codecserver-driver-softmbe libmbe1

#DRM
mkdir build
cd build
apt -y install qt5-qmake libpulse0 libfaad2 libopus0 libpulse-dev libfaad-dev libopus-dev libfftw3-dev g++ make
wget https://downloads.sourceforge.net/project/drm/dream/2.1.1/dream-2.1.1-svn808.tar.gz
tar xvfz dream-2.1.1-svn808.tar.gz
cd dream
qmake -qt=qt5 CONFIG+=console
make
make install
cd ../..

rm -R build

dpkd -i /var/lib/opewebrx/openwebrx*.deb

{ echo; echo '[device:softmbe]'; echo 'driver=softmbe'; echo 'unvoiced_quality=3'; } |  tee -a /etc/codecserver/codecserver.conf
 systemctl restart codecserver


