#!/bin/bash
#This script can install or unistall Seqs-Extractor   in your PC
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
echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
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
	echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo "${textreset}"
	echo    "--------------------------------------------------------------------------------"
	echo    "                         Configuration script                             "
	echo    "--------------------------------------------------------------------------------"
		echo ""
	echo "Choose an option bellow:

${green} 1${textreset} to install Seqs-Extractor  and all required tools 
${green} 2${textreset} to uninstall Seqs-Extractor  and all required tools
${green} 3${textreset} to reinstall Seqs-Extractor  and all required tools"
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

if 
#INSTALL AND COPY FILES AND APPS
sudo apt-get update

#Reinstall samtools
sudo apt-get install samtools -y
apt-get install build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev libssl-dev -y
mkdir samtools/samtools-1.4
tar -xzf samtools/samtools-1.4.tar.gz -C samtools/samtools-1.4
./samtools/samtools-1.4/configure
make -C samtools/samtools-1.4
make install -C samtools/samtools-1.4
rm -rf samtools/samtools-1.4/
rm -f config.h config.log config.mk config.status

#Reinstall BLAST+
sudo apt-get purge ncbi-blast+ -y
sudo apt-get purge ncbi-blast -y
sudo dpkg -i blast+.tools/ncbi-blast_2.6.0+-2_amd64.deb

#install other apps
sudo apt-get install gedit -y
sudo cp misa.tools/misa.pl /usr/local/sbin/misa.pl
sudo cp misa.tools/misa.ini /usr/local/sbin/misa.ini
sudo cp seqs-extractor.tools/SeqsExtractor-1.0 /usr/local/sbin/seqs-extractor
sudo cp seqs-extractor.tools/seqs-extractor_icon.png /usr/local/sbin
sudo chmod +x /usr/local/sbin/seqs-extractor
sudo chmod -f 777 -R /usr/local/sbin/seqs-extractor
sudo chmod +x /usr/local/sbin/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/misa.ini

then
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"Seqs-Extractor  INSTALLED SUCCESSFULLY!"
else
	echo "${red}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"AN ERROR OCCURRED DURING THE INSTALLATION OF Seqs-Extractor!"
fi
fi


if [ $inst_opt = "2" ]; then

#REMOVE FILES AND APPS
sudo apt-get update

#Uninstall samtools
sudo apt-get purge samtools -y
rm -f /usr/local/bin/samtools
rm -f /usr/local/bin/samtools.pl

#Reinstall BLAST+
sudo apt-get purge ncbi-blast+ -y
sudo apt-get purge ncbi-blast -y


sudo rm -f -r /usr/local/sbin/seqs-extractor
sudo rm -f -r /usr/local/sbin/seqs-extractor_icon.png
sudo rm -f /usr/share/applications/Sequences-Extractor.desktop
sudo rm -f -r /usr/local/sbin/misa.ini
sudo rm -f -r /usr/local/sbin/misa.pl
				
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"UNINSTALLATION SUCCESSFULLY"
	echo	"Apps removed: Seqs-Extractor, ncbi-blast+, samtools, MISA"

		fi


if [ $inst_opt = "3" ]; then
#REMOVE FILES AND APPS
sudo rm -f /usr/local/sbin/seqs-extractor
sudo apt-get update
sudo apt-get remove samtools -y
sudo apt-get update
sudo apt-get purge -y ncbi-blast+


#REINSTALL FILES AND APPS

#Reinstall samtools
mkdir samtools/samtools-1.4
tar -xzf samtools/samtools-1.4.tar.gz -C samtools/samtools-1.4
./samtools/samtools-1.4/configure
make -C samtools/samtools-1.4
make install -C samtools/samtools-1.4


#Reinstall BLAST+
sudo dpkg -i blast+.tools/ncbi-blast_2.6.0+-2_amd64.deb

#Reinstall other apps
sudo apt-get install gedit -y
sudo cp misa.tools/misa.pl /usr/local/sbin/misa.pl
sudo cp misa.tools/misa.ini /usr/local/sbin/misa.ini
sudo cp seqs-extractor.tools/SeqsExtractor-1.0 /usr/local/sbin/seqs-extractor
sudo cp seqs-extractor.tools/seqs-extractor_icon.png /usr/local/sbin/seqs-extractor_icon.png
sudo chmod -f 777 -R /usr/local/sbin/seqs-extractor
sudo chmod +x /usr/local/sbin/seqs-extractor
sudo chmod +x /usr/local/sbin/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/misa.ini
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 0.9 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"Seqs-Extractor  REINSTALLED SUCCESSFULLY!
"
fi

if [ $inst_opt = "1" ]; then
sudo echo > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "[Desktop Entry]" > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Type=Application" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Terminal=true" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Name=Seqs-Extractor " >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Icon=/usr/local/sbin/seqs-extractor_icon.png" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Exec=/usr/local/sbin/seqs-extractor" >> /usr/share/applications/Sequences-Extractor.desktop
fi

if [ $inst_opt = "3" ]; then
sudo echo > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "[Desktop Entry]" > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Type=Application" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Terminal=true" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Name=Seqs-Extractor " >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Icon=/usr/local/sbin/seqs-extractor_icon.png" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Exec=/usr/local/sbin/seqs-extractor" >> /usr/share/applications/Sequences-Extractor.desktop
fi
