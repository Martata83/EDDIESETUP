#!/bin/bash
echo "****************************************************************************************"
echo "****************************************************************************************"
echo "Verzeichniss /home/edison kreiern"
cd /home && mkdir edison
echo ""
echo "****************************************************************************************"
echo "ftp kopieren"
cp /tmp/ftp /usr/bin/ftp
chmod a+xwr /usr/bin/ftp
echo ""
echo "****************************************************************************************"
echo "opkgupdate"
echo "src all     http://iotdk.intel.com/repos/1.1/iotdk/all" > /etc/opkg/base-feeds.conf 
echo "src x86 http://iotdk.intel.com/repos/1.1/iotdk/x86"  >> /etc/opkg/base-feeds.conf
echo "src i586    http://iotdk.intel.com/repos/1.1/iotdk/i586" >> /etc/opkg/base-feeds.conf
opkg update
echo ""
echo "****************************************************************************************"
echo "git installieren" 
opkg install git
echo ""
echo "****************************************************************************************"
echo "Setuptools installieren" 
cd /tmp/ && wget https://bootstrap.pypa.io/ez_setup.py -O - | python
echo ""
echo "****************************************************************************************"
echo "importlib neu einstallieren wegen pyserial"
git clone https://github.com/20minutes/importlib.git && cd importlib && python setup.py install
echo ""
echo "****************************************************************************************"
echo "Python Serial Treiber installieren"
cd /tmp 
easy_install -U pyserial
echo ""
echo "****************************************************************************************"
echo "Python Mongo lib installieren"
cd /tmp 
easy_install -U pymongo
echo ""
echo "****************************************************************************************"
echo "Python pip installieren"
cd /tmp 
easy_install pip
echo ""
echo "****************************************************************************************"
echo "Python dateutils installieren"
cd /tmp
pip install python-dateutil
echo ""
echo "****************************************************************************************"
echo "Zeitzone setzen"
cd /tmp
timedatectl set-timezone Europe/Paris
echo ""
echo "****************************************************************************************"
echo "Aus kompatibilitäts gründen zu pi einen link von nodejs auf node kreiern"
cd /tmp && ln -s /usr/bin/node /usr/bin/nodejs
echo ""
echo "****************************************************************************************"
echo "cronie installieren"
cd /tmp && wget http://repo.opkg.net/edison/repo/core2-32/cronie_1.4.11-r0_core2-32.ipk
opkg install cronie_1.4.11-r0_core2-32.ipk
echo ""
echo "****************************************************************************************"
echo "mmoewlink installieren (installiert automatisch decocare)"
cd /home/edison/ && git clone https://github.com/oskarpearson/mmeowlink.git && cd mmeowlink && python setup.py install
echo ""
echo "****************************************************************************************"
echo "openaps installieren"
cd /tmp/ && git clone https://github.com/openaps/openaps.git && cd openaps && python setup.py install
echo ""
echo "****************************************************************************************"
echo "decoding carelink installieren aus dev"
cd /tmp && git clone -b dev https://github.com/bewest/decoding-carelink.git && cd decoding-carelink && python setup.py install
echo ""
echo "****************************************************************************************"
echo "MC installieren"
cd /tmp && wget http://ftp.midnight-commander.org/mc-4.6.1.tar.gz && tar -zxvf mc-4.6.1.tar.gz && cd mc-4.6.1 && ./configure && make && make install
echo ""
echo "****************************************************************************************"
echo "cctl installieren"
cd /home/edison
mkdir erf
cd erf
curl -L -O https://github.com/ps2/subg_rfspy/releases/download/v0.6/uart0_alt1_SRF_ERF_WW_CCTL.hex 
git clone https://github.com/ps2/subg_rfspy.git
git clone https://github.com/oskarpearson/cctl.git
cd cctl
git checkout 24mhz_clock_and_erf_stick_hack
cd cctl-prog
make
echo ""
echo "****************************************************************************************"
echo "wenn alles gut gelaufen ist könnte mann nun mit eddie arbeiten"
