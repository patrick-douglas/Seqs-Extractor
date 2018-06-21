#!/bin/bash
#This script can install or unistall Seqs-Extractor   in your PC
w=$(tput sgr0) 
r=$(tput setaf 1)
g=$(tput setaf 2) 
o=$(tput setaf 8) 
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [[ $EUID -ne 0 ]]; then
echo 	"${g}"
echo	"________________________________________________________________________________"
echo 	""
echo    "______________________________ Seqs-Extractor 1.0 ______________________________"
echo	"________________________________________________________________________________"
echo 	""
	echo ""
   echo "${r}ERROR: THIS SCRIPT MUST BE RUN AS ROOT" 1>&2
	echo ""
   exit 1
fi

clear


	echo "${g}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 1.0 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo "${w}"
	echo    "--------------------------------------------------------------------------------"
	echo    "                         Configuration script                             "
	echo    "--------------------------------------------------------------------------------"
		echo ""
	echo "Choose an option bellow:

${g} 1${w} to install Seqs-Extractor  and all required tools 
${g} 2${w} to uninstall Seqs-Extractor  and all required tools"
		echo "${g}"
		read inst_opt
		echo "${w}"

if [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ]
then
echo "${r}"
while 
read -p 'Try again: ' inst_opt && [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ] ; do
echo "${r}
-------------------------------------------------------------
ERROR ${w}$inst_opt${r} IS NOT A VALID OPTION, PLEASE CHOOSE A VALID OPTION!
-------------------------------------------------------------
"
done
fi
echo "${w}"

if [ $inst_opt = "1" ]; then

#Set -j option during make process
nproc > .cpu.txt
	threads=`cat .cpu.txt`

apt-get install build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev libssl-dev -y
#INSTALL AND COPY FILES AND APPS
sudo apt-get update

#bzip
tar -zxf samtools/bzip2-1.0.6.tar.gz -C samtools/
make -j $threads -C samtools/bzip2-1.0.6
sudo make -j $threads install -C samtools/bzip2-1.0.6
rm -rf samtools/bzip2-1.0.6

#XZ
tar -zxf samtools/xz-5.2.3.tar.gz -C samtools/
./samtools/xz-5.2.3/configure
make -j $threads -C samtools/xz-5.2.3
sudo make -j $threads install -C samtools/xz-5.2.3
rm -rf samtools/xz-5.2.3

#BCFtools
mkdir -p samtools/bcftools-1.7
tar -zxf samtools/bcftools-1.7.tar.gz -C samtools/bcftools-1.7
./samtools/bcftools-1.7/configure
sudo make -j $threads prefix=/usr/local/bin install -C samtools/bcftools-1.7
sudo make -j $threads install -C samtools/bcftools-1.7
sudo ln -s /usr/local/bin/bin/bcftools /usr/bin/bcftools
rm -rf samtools/bcftools-1.7

#HTSLIB
mkdir -p samtools/htslib-1.7
tar -zxf samtools/htslib-1.7.tar.gz -C samtools/htslib-1.7
samtools/htslib-1.7/configure
make -j $threads -C samtools/htslib-1.7
sudo make -j $threads install -C samtools/htslib-1.7
rm -rf samtools/htslib-1.7

#SAmtools
mkdir -p samtools/samtools-1.8
tar -xzf samtools/samtools-1.8.tar.gz -C samtools/samtools-1.8
./samtools/samtools-1.8/configure
make -j $threads -C samtools/samtools-1.8
sudo make -j $threads install -C samtools/samtools-1.8
rm -rf samtools/samtools-1.8
rm -rf config.h config.log config.mk config.status Makefile debug lib po src tests Doxyfile libtool stamp-h1 htslib.pc.tmp .cpu.txt htslib.pc.tmp

#Reinstall BLAST+------------------------------------------
if [ -f blast+.tools/ncbi-blast_2.7.1+-2_amd64.deb ];
then
	echo ""
else
mkdir -p blast+.tools
wget https://ufpr.dl.sourceforge.net/project/seqs-extractor/Linux-Debiam/blast%2B.tools/ncbi-blast_2.7.1%2B-2_amd64.deb --directory-prefix=blast+.tools/
echo	" "
fi
#Reinstall BLAST+------------------------------------------
sudo apt-get purge ncbi-blast+ -y
sudo apt-get purge ncbi-blast -y
sudo apt-get purge blast2 -y
sudo dpkg -i blast+.tools/ncbi-blast_2.7.1+-2_amd64.deb

#install other apps
sudo apt-get install gedit -y

sudo mkdir -p /usr/local/sbin/seqs-extractor

sudo cp seqs-extractor.tools/1-only_blast /usr/local/sbin/seqs-extractor/1-only_blast
sudo chmod +x /usr/local/sbin/seqs-extractor/1-only_blast

sudo cp seqs-extractor.tools/2-blast-and-extract /usr/local/sbin/seqs-extractor/2-blast-and-extract
sudo chmod +x /usr/local/sbin/seqs-extractor/2-blast-and-extract

sudo cp seqs-extractor.tools/3-only-extract /usr/local/sbin/seqs-extractor/3-only-extract
sudo chmod +x /usr/local/sbin/seqs-extractor/3-only-extract

sudo cp seqs-extractor.tools/4-extract-from-misa /usr/local/sbin/seqs-extractor/4-extract-from-misa
sudo chmod +x /usr/local/sbin/seqs-extractor/4-extract-from-misa

sudo cp seqs-extractor.tools/5-run-misa-and-extract /usr/local/sbin/seqs-extractor/5-run-misa-and-extract
sudo chmod +x /usr/local/sbin/seqs-extractor/5-run-misa-and-extract

sudo cp seqs-extractor.tools/6-extract-using-txt /usr/local/sbin/seqs-extractor/6-extract-using-txt
sudo chmod +x /usr/local/sbin/seqs-extractor/6-extract-using-txt

sudo cp seqs-extractor.tools/7-customize-misa.ini.file /usr/local/sbin/seqs-extractor/7-customize-misa.ini.file
sudo chmod +x /usr/local/sbin/seqs-extractor/7-customize-misa.ini.file

sudo cp seqs-extractor.tools/SeqsExtractor /usr/local/sbin/SeqsExtractor
sudo chmod +x /usr/local/sbin/SeqsExtractor
sudo chmod -f 777 -R /usr/local/sbin/SeqsExtractor
sudo cp seqs-extractor.tools/seqs-extractor_icon.png /usr/local/sbin/seqs-extractor/

sudo cp misa.tools/misa.pl /usr/local/sbin/seqs-extractor/misa.pl
sudo cp misa.tools/misa.ini /usr/local/sbin/seqs-extractor/misa.ini
sudo chmod -f 777 -R /usr/local/sbin/seqs-extractor/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/seqs-extractor/misa.ini
sudo chmod +x /usr/local/sbin/seqs-extractor/misa.pl
sudo echo > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "[Desktop Entry]" > /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Type=Application" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Terminal=true" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Name=Seqs-Extractor " >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Icon=/usr/local/sbin/seqs-extractor/seqs-extractor_icon.png" >> /usr/share/applications/Sequences-Extractor.desktop
		sudo echo "Exec=/usr/local/sbin/SeqsExtractor" >> /usr/share/applications/Sequences-Extractor.desktop
	echo "${g}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 1.0 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"Seqs-Extractor  INSTALLED SUCCESSFULLY!"
else
	echo "${r}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 1.0 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"AN ERROR OCCURRED DURING THE INSTALLATION OF Seqs-Extractor!"
fi



if [ $inst_opt = "2" ]; then

#REMOVE FILES AND APPS
sudo apt-get update

##Uninstall samtools
#sudo apt-get purge samtools -y
#rm -f /usr/local/bin/samtools
#rm -f /usr/local/bin/samtools.pl

#Reinstall BLAST+
sudo apt-get purge ncbi-blast+ -y
sudo apt-get purge ncbi-blast -y

sudo rm -rf /usr/local/sbin/SeqsExtractor
sudo rm -rf /usr/local/sbin/seqs-extractor/
sudo rm -f /usr/share/applications/Sequences-Extractor.desktop

				
clear
	echo "${g}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "______________________________ Seqs-Extractor 1.0 ______________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"UNINSTALLATION SUCCESSFULLY"
	echo	"Apps removed: Seqs-Extractor, ncbi-blast+, samtools, MISA"

		fi

rm -rf config.h config.log config.mk config.status Makefile debug lib po src tests Doxyfile libtool stamp-h1 htslib.pc.tmp .cpu.txt

