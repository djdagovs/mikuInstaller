#!/bin/bash


if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, anda perlu ada akses root"
	exit 1
fi

if [[ ! -e /dev/net/tun ]]; then
	echo "TUN tidak dihidupkan!"
	exit 2
fi

if [[ -e /etc/debian_version ]]; then
	OS="debian"
	# Getting the version number, to verify that a recent version of OpenVPN is available
	VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
	RCLOCAL='/etc/rc.local'
	SYSCTL='/etc/sysctl.conf'
	if [[ "$VERSION_ID" != 'VERSION_ID="7"' ]]; then
		echo "Versi Debian ini bukan Debian 7."
		echo "Script ini tidak dapat dijalankan pada vps ini mungkin disebabkan masalah OS/Versi OS."
		echo ""
		echo "jIka, ingin meneruskan script ini pada vps anda (perhatian tidak stabil!),"
		echo "maka sila pilih (y)."
		echo "sila ingat ianya tidak stabil!."
		while [[ $CONTINUE != "y" && $CONTINUE != "n" ]]; do
			read -p "Continue ? [y/n]: " -e CONTINUE
		done
		if [[ "$CONTINUE" = "n" ]]; then
			echo "Ok, bye !"
			exit 4
                fi

#starting
echo "all pass starting the installler"
echo "================================"
echo ""
wget "https://raw.githubusercontent.com/hajimxmiku/mikuInstaller/master/MikuSetupInstaller.sh"
bash MikuSetupInstaller.sh
echo ""
