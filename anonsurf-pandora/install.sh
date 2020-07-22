#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root"
	exit 1
fi
rm -f /etc/apt/sources.list.d/i2p.list
echo "deb http://deb.i2p2.no/ unstable main" > /etc/apt/sources.list.d/i2p.list 
wget https://geti2p.net/_static/i2p-debian-repo.key.asc -O /tmp/i2p-debian-repo.key.asc 
apt-key add /tmp/i2p-debian-repo.key.asc # Import the key
rm /tmp/i2p-debian-repo.key.asc # delete the temp key
apt-get update # Update repos
apt-get install libservlet3.0-java -y
wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
dpkg -i libjetty8-java_8.1.16-4_all.deb 
apt-get install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni -y 
apt-get -f install 
apt-get install -y i2p-keyring 
apt-get install -y secure-delete tor i2p 
dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb 
dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb) 
exit 0
