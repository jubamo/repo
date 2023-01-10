#!/bin/sh

apt update
apt upgrade

apt install -y git build-essential debhelper libfftw3-dev libsamplerate0-dev cmake dh-python python3-all libpython3-dev  python3-setuptools librtlsdr-dev libsoapysdr-dev soapysdr-tools wget usbip unzip build-essential cmake libusb-1.0-0-dev pkg-config usbip hwdata usbutils asciidoc automake libtool texinfo gfortran libhamlib-dev qtbase5-dev qtmultimedia5-dev qttools5-dev asciidoctor libqt5serialport5-dev qttools5-dev-tools libudev-dev xsltproc libboost-dev libboost-log-dev libboost-regex-dev wget git-core debhelper cmake libprotobuf-dev protobuf-compiler sox libprotobuf-dev protobuf-compiler libudev-dev libicu-dev libboost-program-options-dev libboost-program-options-dev qt5-qmake libpulse0 libfaad2 libopus0 libpulse-dev libfaad-dev libopus-dev libfftw3-dev direwolf libflac-dev libogg-dev libsndfile1-dev libvorbis-dev netcat netcat-openbsd rtl-sdr

git clone -b master https://github.com/luarvique/csdr.git
cd csdr/
dpkg-buildpackage -us -uc
cd ..
dpkg -i libcsdr-dev_0.18.2_*.deb  libcsdr0-dbgsym_0.18.2_*.deb libcsdr0_0.18.2_*.deb csdr_0.18.2_*.deb csdr-dbgsym_0.18.2_*.deb  nmux_0.18.2_*.deb

git clone -b master https://github.com/luarvique/pycsdr.git
cd pycsdr/
dpkg-buildpackage -us -uc
cd ..
dpkg -i python3-csdr-dbgsym_0.18.2_*.deb python3-csdr_0.18.2_*.deb

git clone -b master https://github.com/luarvique/owrx_connector.git
cd owrx_connector
dpkg-buildpackage -us -uc
cd ..
dpkg -i libowrx-connector_0.6.2_*.deb libowrx-connector-dbgsym_0.6.2_*.deb libowrx-connector-dev_0.6.2_*.deb rtl-connector-dbgsym_0.6.2_*.deb rtl-connector_0.6.2_*.deb  rtl-connector_0.6.2_*.deb libowrx-connector_0.6.2_*.deb  rtl-tcp-connector_0.6.2_*.deb  soapy-connector_0.6.2_*.deb  owrx-connector_0.6.2_*.deb  soapy-connector-dbgsym_0.6.2_*.deb

git clone -b master https://github.com/jketterl/js8py.git
cd js8py
python3 setup.py install
cd ..

wget https://github.com/airspy/airspyhf/archive/master.zip
unzip master.zip
cd airspyhf-master/
mkdir build
cd build/
cmake ../ -DINSTALL_UDEV_RULES=ON
make
make install
ldconfig
cd ../..

git clone -b master http://github.com/pothosware/SoapyAirspyHF
cd SoapyAirspyHF/
mkdir build
cd build/
cmake ..
make
make install
ldconfig
cd ../..

git clone -b master https://github.com/jketterl/codecserver.git
cd codecserver
mkdir build
cd build
cmake ..
make
make install
cd ../..
ldconfig
adduser --system --group --no-create-home --home /nonexistent --quiet codecserver
usermod -aG dialout codecserver

git clone -b master https://github.com/jketterl/digiham.git
cd digiham
mkdir build
cd build
cmake ..
make
make install
cd ../..

git clone -b master https://github.com/jketterl/pydigiham.git
cd pydigiham
python3 setup.py install
cd ..

git clone https://github.com/drowe67/codec2.git
cd codec2
mkdir build
cd build
cmake ..
make
make install
install -m 0755 src/freedv_rx /usr/local/bin
cd ../..
ldconfig

git clone https://github.com/mobilinkd/m17-cxx-demod.git
cd m17-cxx-demod/
mkdir build
cd build
cmake ..
make
make install
cd ../..

wget https://sourceforge.net/projects/wsjt/files/wsjtx-2.5.4/wsjtx-2.5.4.tgz
tar xvfz wsjtx-2.5.4.tgz
cd wsjtx-2.5.4
mkdir build
cd build/
cmake ..
make
make install
cd ../..

git clone https://github.com/szechyjs/mbelib.git
cd mbelib/
dpkg-buildpackage
cd ..
dpkg -i libmbe1_1.3.0_*.deb libmbe-dev_1.3.0_*.deb
ldconfig
git clone https://github.com/fventuri/codecserver-mbelib-module.git
cd codecserver-mbelib-module/
mkdir build
cd build/
cmake ..
make
make install
ldconfig
mkdir /usr/local/etc/codecserver
cp ../conf/codecserver.conf /usr/local/etc/codecserver/.
cd ../..

git clone -b master https://github.com/luarvique/openwebrx.git
cd openwebrx/
dpkg-buildpackage -us -uc
cd ..

mkdir packages
cp *.deb ./packages
dpkg -i openwebrx_1.2.2_all.deb

codecserver &
openwebrx

