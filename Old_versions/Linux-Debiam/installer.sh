#!/bin/bash
#This script can install or unistall BLAST Extractor in your PC
textreset=$(tput sgr0) 
red=$(tput setaf 1)
green=$(tput setaf 2) 
orange=$(tput setaf 8) 
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [[ $EUID -ne 0 ]]; then
echo 	"${green}"
echo	"________________________________________________________________________________"
echo 	""
echo    "_________________________ BLAST Extractor 0.9 __________________________________"
echo	"________________________________________________________________________________"
echo 	""
	echo ""
   echo "${red}ERROR: THIS SCRIPT MUST BE RUN AS ROOT" 1>&2
	echo ""
   exit 1
fi

clear


	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ BLAST Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo "${textreset}"
	echo    "--------------------------------------------------------------------------------"
	echo    "                         Configuration script                             "
	echo    "--------------------------------------------------------------------------------"
		echo ""
	echo "Choose an option bellow:

${green} 1${textreset} to install BLAST Extractor
${green} 2${textreset} to uninstall BLAST Extractor
${green} 3${textreset} to reinstall BLAST Extractor"
		echo "${green}"
		read inst_opt
		echo "${textreset}"


if [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ] && [ "$inst_opt" != "3" ]
then
echo "${red}"
while 
read -p 'Try again: ' inst_opt && [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ] && [ "$inst_opt" != "3" ] ; do
echo "${red}
-------------------------------------------------------------
ERROR ${textreset}$inst_opt${red} IS NOT A VALID OPTION, PLEASE CHOOSE A VALID OPTION!
-------------------------------------------------------------
"
done
fi

if [ $inst_opt = "1" ]; then
sudo apt-get update
sudo apt-get install ncbi-blast+ -y
sudo apt-get install samtools -y
sudo cp BLAST_Extractor-0.9 /usr/local/sbin/blast-extractor
sudo cp blast-extractor_icon.png /usr/local/sbin
sudo chmod +x /usr/local/sbin/blast-extractor
sudo chmod -f 777 -R /usr/local/sbin/blast-extractor
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ BLAST Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"BLAST EXTRACTOR INSTALLED SUCCESSFULLY!
"


fi


if [ $inst_opt = "2" ]; then

	if
	[ ! -f /usr/local/sbin/blast-extractor ]
		then
			echo 'BLAST Extractor already uninstalled!'
 
	elif
		[ -f /usr/local/sbin/blast-extractor ]
		then
		sudo apt-get update
		sudo apt-get remove ncbi-blast+ -y
		sudo apt-get remove samtools -y
		sudo rm -f -r /usr/local/sbin/blast-extractor
		sudo rm -f -r /usr/local/sbin/blast-extractor_icon.png
		sudo rm -f /usr/share/applications/BLAST-Extractor.desktop
		echo 'BLAST Extractor successfully uninstalled!'
		
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ BLAST Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"BLAST EXTRACTOR UNINSTALLED SUCCESSFULLY!
"

		fi
fi

if [ $inst_opt = "3" ]; then
sudo rm -f /usr/local/sbin/blast-extractor
sudo apt-get update
sudo apt-get remove ncbi-blast+ -y
sudo apt-get remove samtools -y
sudo apt-get update
sudo apt-get install ncbi-blast+ -y
sudo apt-get install samtools -y
sudo cp BLAST_Extractor-0.9 /usr/local/sbin/blast-extractor
sudo cp blast-extractor_icon.png /usr/local/sbin/blast-extractor_icon.png
sudo chmod -f 777 -R /usr/local/sbin/blast-extractor
sudo chmod +x /usr/local/sbin/blast-extractor
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ BLAST Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"BLAST EXTRACTOR REINSTALLED SUCCESSFULLY!
"
fi

if [ $inst_opt = "1" ]; then
sudo echo > /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "[Desktop Entry]" > /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Type=Application" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Terminal=true" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Name=BLAST Extractor" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Icon=/usr/local/sbin/blast-extractor_icon.png" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Exec=/usr/local/sbin/blast-extractor" >> /usr/share/applications/BLAST-Extractor.desktop
fi

if [ $inst_opt = "3" ]; then
sudo echo > /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "[Desktop Entry]" > /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Type=Application" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Terminal=true" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Name=BLAST Extractor" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Icon=/usr/local/sbin/blast-extractor_icon.png" >> /usr/share/applications/BLAST-Extractor.desktop
		sudo echo "Exec=/usr/local/sbin/blast-extractor" >> /usr/share/applications/BLAST-Extractor.desktop
fi

