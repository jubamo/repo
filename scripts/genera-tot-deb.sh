#!/usr/bin/env bash

cd /var/lib/openwebrx

mkdir owrx.deb
cd owrx.deb

apt update
apt upgrade -y
apt install -y wget gpg
wget -O - https://repo.openwebrx.de/debian/key.gpg.txt | gpg --dearmor -o /usr/share/keyrings/openwebrx.gpg
echo "deb [signed-by=/usr/share/keyrings/openwebrx.gpg] https://repo.openwebrx.de/debian/ bullseye main" > /etc/apt/sources.list.d/openwebrx.list
apt-get update


apt install -y git build-essential debhelper libfftw3-dev libsamplerate0-dev cmake dh-python python3-all libpython3-dev  python3-setuptools librtlsdr-dev libsoapysdr-dev soapysdr-tools \
    debhelper libprotobuf-dev protobuf-compiler

apt install -y libcodecserver-dev openwebrx

git clone -b master https://github.com/luarvique/csdr.git
cd csdr/
 dpkg-buildpackage -us -uc
cd ..
  dpkg -i libcsdr-dev_0.18.2_amd64.deb  libcsdr0-dbgsym_0.18.2_amd64.deb libcsdr0_0.18.2_amd64.deb csdr_0.18.2_amd64.deb csdr-dbgsym_0.18.2_amd64.deb  nmux_0.18.2_amd64.deb

git clone -b master https://github.com/luarvique/pycsdr.git
cd pycsdr/
  dpkg-buildpackage -us -uc
cd ..
  dpkg -i python3-csdr-dbgsym_0.18.2_amd64.deb python3-csdr_0.18.2_amd64.deb


git clone -b master https://github.com/luarvique/owrx_connector.git
  cd owrx_connector/
  dpkg-buildpackage -us -uc
  cd ..
dpkg -i libowrx-connector_0.6.2_amd64.deb libowrx-connector-dbgsym_0.6.2_amd64.deb libowrx-connector-dev_0.6.2_amd64.deb rtl-connector-dbgsym_0.6.2_amd64.deb rtl-connector_0.6.2_amd64.deb  rtl-connector_0.6.2_amd64.deb libowrx-connector_0.6.2_amd64.deb  rtl-tcp-connector_0.6.2_amd64.deb  soapy-connector_0.6.2_amd64.deb  owrx-connector_0.6.2_amd64.deb  soapy-connector-dbgsym_0.6.2_amd64.deb

git clone -b master https://github.com/luarvique/openwebrx.git
  cd openwebrx/
  dpkg-buildpackage -us -uc
cd ..

git clone https://github.com/szechyjs/mbelib.git
cd mbelib
dpkg-buildpackage -us -uc
cd ..
dpkg -i  libmbe-dev_1.3.0_*.deb libmbe1_1.3.0_*.deb

git clone https://github.com/knatterfunker/codecserver-softmbe.git
  cd codecserver-softmbe
  dpkg-buildpackage -us -uc
cd ..

mkdir paquetes
cp *.deb ./paquetes
rm ./paquetes/*dbgsym*
