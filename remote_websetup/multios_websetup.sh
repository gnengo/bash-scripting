#!/bin/bash

# Variable Declaration
#PACKAGE="httpd wget unzip"
#SVC="httpd"
URL='https://www.tooplate.com/zip-templates/2098_health.zip'
ART_NAME='2098_health'
TEMPDIR="/tmp/webfiles"

yum --help &> /dev/null

if [ $? -eq 0 ]
then 
	PACKAGE="httpd wget unzip"
	SVC="httpd"
	echo "Running Setup on CentOS"


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

	wget $URL > /dev/null
	unzip $ART_NAME.zip > /dev/null
	sudo cp -r $ART_NAME/* /var/www/html
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

else
        PACKAGE="apache2 wget unzip"
        SVC="apache2"
        echo "Running Setup on Ubuntu"


        # Installing dependencies
        echo "###################################"
        echo "Installing packages."
        echo "###################################"

	sudo apt update

        sudo apt install $PACKAGE -y > /dev/null
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

        wget $URL > /dev/null
        unzip $ART_NAME.zip > /dev/null
        sudo cp -r $ART_NAME/* /var/www/html
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
fi
