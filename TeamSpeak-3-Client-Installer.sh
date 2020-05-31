#!/bin/bash

INSTALLER_VERSION="1.0.1"
TS3CLIENT_VERSION="3.5.3"
TS3CLIENT_LOGO="https://dl.arrow-systems.de/github/teamspeak-3-client-installer/logo.png"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

clear

echo "Unofficial TeamSpeak 3 Client Auto-Installer"
sleep 0.4
echo "Version: v$INSTALLER_VERSION"
sleep 3

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

	# Create ts3client.desktop and write text inside
	echo "Create ts3client.desktop"
	touch ts3client.desktop

echo "[Desktop Entry]
Name=Teamspeak 3 Client
VERSION=$TS3CLIENT_VERSION
GenericName=TeamSpeak3
Comment=Speak with friends
Comment[de]=Spreche mit Freunden
Exec=/opt/teamspeak/ts3client/ts3client_runscript.sh
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=/opt/teamspeak/ts3client/logo.png
Categories=Network;
StartupWMClass=TeamSpeak 3
StartupNotify=true" > ts3client.desktop

	sleep 2
	clear

	# Download Logo
	echo "Download logo and move it to TeamSpeak3-Client-linux_amd64..."
	sleep 3
	wget $TS3CLIENT_LOGO -O TeamSpeak3-Client-linux_amd64/logo.png

	sleep 2
	clear

	# Copy files to /opt/teamspeak/ts3client/ and /usr/share/applications/ts3client.desktop
	echo "Move TeamSpeak3-Client-linux_amd64 to /opt/teamspeak/ts3client/"
	echo "and ts3client.desktop to /usr/share/applications/ts3client.desktop"
	sleep 3

	if [ ! -d /opt/teamspeak/ ]; then
		mkdir -p /opt/teamspeak/
	fi

	if [ -f /usr/share/applications/ts3client.desktop ] ; then
		rm /usr/share/applications/ts3client.desktop
	fi

	mv ./TeamSpeak3-Client-linux_amd64 /opt/teamspeak/ts3client/
	mv ts3client.desktop /usr/share/applications/ts3client.desktop

	sleep 2
	clear

	# Give Folder full rights
	echo "Give folder 777 rights to execute it from a non-root-user"
	sleep 3
	chmod -R 777 /opt/teamspeak/ts3client/

	# Go to /home and delete temporary folder
	echo "Delete temporary folder..."
	cd /home
	rm -rf /var/tmp/teamspeak-3-client-installer/

	sleep 2
	clear

# End
echo "TeamSpeak 3 Client Version $TS3CLIENT_VERSION successfully installed at location"
echo "/opt/teamspeak/ts3client/"
echo
sleep 2


echo "Following Websites using:"
echo "files.teamspeak-services.com, dl.arrow-systems.de"
echo
sleep 2

echo "Script by Razuuu (https://www.github.com/Razuuu)"
echo "Thank you for using this Installer!"

exit 0
