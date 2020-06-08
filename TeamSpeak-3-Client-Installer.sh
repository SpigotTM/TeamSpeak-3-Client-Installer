#!/bin/bash

SCRIPT_FILE="TeamSpeak-3-Client-Installer.sh"
INSTALLER_VERSION="1.0.7"
TS3CLIENT_VERSION=$1
TS3CLIENT_LOGO="https://dl.arrow-systems.de/github/teamspeak-3-client-installer/logo.png"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

if [ -z $1 ]; then
   echo "./$SCRIPT_FILE <TS3Client-Version>"
   echo "Stable: 3.5.3"
   exit 1
fi

clear

echo "Unofficial TeamSpeak 3 Client Auto-Installer"
sleep 0.4
echo "Version: v$INSTALLER_VERSION"
sleep 3
n>.desktopn>.desktop
clear

	# Temporary Folder and go inside
	echo "Create temporary folder for this script and go to the folder..."
	sleep 3
	mkdir -p /var/tmp/teamspeak-3-client-installer/
	cd /var/tmp/teamspeak-3-client-installer/

	sleep 2
	clear

	# Download File
	echo "Download file TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run"
	sleep 3
	wget https://files.teamspeak-services.com/releases/client/$TS3CLIENT_VERSION/TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep 2
	clear

	# Give file execute rights and run
	echo "Give File execute rights..."
	sleep 3
	chmod +x TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep 2
	clear

	echo "Run file, please follow instructions!"
	sleep 3
	bash TeamSpeak3-Client-linux_amd64-$TS3CLIENT_VERSION.run

	sleep 2
	clear

	# Create ts3client-<ts3client_version>.desktop and write text inside
	echo "Create ts3client-$TS3CLIENT_VERSION.desktop"
	touch ts3client-$TS3CLIENT_VERSION.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client - $TS3CLIENT_VERSION
VERSION=$TS3CLIENT_VERSION
GenericName=TeamSpeak3 $TS3CLIENT_VERSION
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/client/3/$TS3CLIENT_VERSION/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/client/3/$TS3CLIENT_VERSION/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3 $TS3CLIENT_VERSION
StartupNotify=true" > ts3client-$TS3CLIENT_VERSION.desktop

	sleep 2
	clear

	# Download Logo
	echo "Download logo and move it to TeamSpeak3-Client-linux_amd64..."
	sleep 3
	wget $TS3CLIENT_LOGO -O TeamSpeak3-Client-linux_amd64/logo.png

	sleep 2
	clear

	# Copy files to /opt/teamspeak/client/3/<ts3client_version>/ and /usr/share/applications/ts3client-<ts3client_version>.desktop
	echo "Move TeamSpeak3-Client-linux_amd64 to /opt/teamspeak/client/3/$TS3CLIENT_VERSION/"
	echo "and ts3client-$TS3CLIENT_VERSION.desktop to /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop"
	sleep 3

	# if shit start
	if [ ! -d /opt/teamspeak/ ]; then
		mkdir -p /opt/teamspeak/
	fi
	
	if [ ! -d /opt/teamspeak/client/ ]; then
		mkdir -p /opt/teamspeak/client/
	fi
	
	if [ ! -d /opt/teamspeak/client/3/ ]; then
		mkdir -p /opt/teamspeak/client/3/
	fi
	
	if [ ! -d /opt/teamspeak/client/3/$TS3CLIENT_VERSION/ ]; then
		mkdir -p /opt/teamspeak/client/3/$TS3CLIENT_VERSION/
	fi

	if [ -f /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop ]; then
		rm /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop
	fi
	# if shit stop 

	# fix FUCKING not changing folder v2
	mkdir -p temp_$TS3CLIENT_VERSION
	mv TeamSpeak3-Client-linux_amd64/* temp_$TS3CLIENT_VERSION/
	
	
	mv temp_$TS3CLIENT_VERSION/* /opt/teamspeak/client/3/$TS3CLIENT_VERSION/
	mv ts3client-$TS3CLIENT_VERSION.desktop /usr/share/applications/ts3client-$TS3CLIENT_VERSION.desktop

	sleep 2
	clear

	# Give Folder full rights
	echo "Give folder 777 rights to execute it from a non-root-user"
	sleep 3
	chmod -R 777 /opt/teamspeak/client/3/$TS3CLIENT_VERSION/

	# Go to /home and delete temporary folder
	echo "Delete temporary folder..."
	cd /home
	rm -rf /var/tmp/teamspeak-3-client-installer/

	sleep 2
	clear

# End
echo "TeamSpeak 3 Client Version $TS3CLIENT_VERSION successfully"
echo "installed at location: /opt/teamspeak/client/3/$TS3CLIENT_VERSION/"
echo
sleep 2


echo "Following Websites using:"
echo "files.teamspeak-services.com, dl.arrow-systems.de"
echo
sleep 2

echo "Script by Razuuu (https://www.github.com/Razuuu)"
echo "Thank you for using this Installer! (v$INSTALLER_VERSION)"

exit 0
