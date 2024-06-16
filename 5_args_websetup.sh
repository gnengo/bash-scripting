#!/bin/bash

# Variable Declaration
PACKAGE="httpd wget unzip"
SVC="httpd"
#URL='https://www.tooplate.com/zip-templates/2098_health.zip'
#ART_NAME='2098_health'
TEMPDIR="/tmp/webfiles"


# Installing dependencies
echo "###################################"
echo "Installing packages."
echo "###################################"

sudo yum install $PACKAGE -y > /dev/null
echo

#Start and enable service
echo "###################################"
echo "Start and enable HTTPD service"
echo "###################################"
sudo systemctl start $SVC
sudo systemctl enable $SVC
echo

#Creating temp directory
echo "###################################"
echo "Starting artifact deployment"
echo "###################################"
mkdir -p $TEMPDIR
cd $TEMPDIR
echo

wget $1 > /dev/null
unzip $2.zip > /dev/null
sudo cp -r $2/* /var/www/html
echo

#Bounce service
echo "###################################"
echo "Restarting HTTPD service"
echo "###################################"
systemctl restart $SVC
echo

# Clean up
echo "###################################"
echo "Removing temporary files"
echo "###################################"
rm -rf $TEMPDIR
echo

sudo systemctl status $SVC
ls /var/www/html
