#!/bin/bash
#This script can install or unistall Seqs-Extractor into your PC
w=$(tput sgr0) 
r=$(tput setaf 1)
g=$(tput setaf 2) 
o=$(tput setaf 8)
y=$(tput setaf 3)  
FILE="/tmp/out.$$"
GREP="/bin/grep"

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	echo "Connection OK${g}"
else
echo "Ouch!!!${r}"
echo	"--------------------------------------------------------------------------------------------------------"
echo	"You are OFFLINE, your computer need to be connected to the Internet to install updates and some packages"
echo	"Without INTERNET connection the installation will no work"
echo	"--------------------------------------------------------------------------------------------------------"
exit 1
fi

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

${g} 1${w} to install SeqsExtractor and all required tools 
${g} 2${w} to uninstall SeqsExtractor and all required tools"
		echo "${g}"
echo -n "" ; read -p "" -n 1 inst_opt
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
threads=`nproc`
sudo apt-get update -qq
apt-get install build-essential libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev libssl-dev -y

#INSTALL AND COPY FILES AND APPS
#install other apps
sudo apt-get install xed -y
sudo apt-get install libxml2-dev -y
sudo apt-get install fort77 -y
sudo apt-get install xorg-dev -y 
sudo apt-get install liblzma-dev libblas-dev gfortran -y
sudo apt-get install gcc-multilib -y
sudo apt-get install gobjc++ -y
sudo apt-get install libcurl4-gnutls-dev -y
sudo apt-get install aptitude -y
sudo aptitude install libreadline-dev -y

#bzip
echo "${y}*******************"
echo 'Bzip'
echo "*******************${w}"
bzip2_tar=master.zip
bzip2_path=bzip2-1.0.6-master/
wget https://github.com/enthought/bzip2-1.0.6/archive/master.zip
unzip -o master.zip -d .
cd $bzip2_path && make -j $threads && make install -j $threads
cd .. && rm -rf $bzip2_path $bzip2_tar
#tar -zxf samtools/bzip2-1.0.6.tar.gz -C samtools/
#make -j $threads -C samtools/bzip2-1.0.6
#sudo make -j $threads install -C samtools/bzip2-1.0.6
#rm -rf samtools/bzip2-1.0.6

#XZ
echo "${y}*******************"
echo 'XZ'
echo "*******************${w}"
xz_path=xz-5.2.4/
xz_tar=xz-5.2.4.tar.gz
wget https://ufpr.dl.sourceforge.net/project/lzmautils/xz-5.2.4.tar.gz
tar -zxf $xz_tar
cd $xz_path && ./configure && make -j $threads && make install -j $threads
cd .. && rm -rf $xz_path $xz_tar
xz_v=`xz -V | grep xz`

#tar -zxf samtools/xz-5.2.3.tar.gz -C samtools/
#./samtools/xz-5.2.3/configure
#make -j $threads -C samtools/xz-5.2.3
#sudo make -j $threads install -C samtools/xz-5.2.3
#rm -rf samtools/xz-5.2.3

#BCFtools
#mkdir -p samtools/bcftools-1.7
#tar -zxf samtools/bcftools-1.7.tar.gz -C samtools/bcftools-1.7
#./samtools/bcftools-1.7/configure
#sudo make -j $threads prefix=/usr/local/bin install -C samtools/bcftools-1.7
#sudo make -j $threads install -C samtools/bcftools-1.7
#sudo ln -s /usr/local/bin/bin/bcftools /usr/bin/bcftools
#rm -rf samtools/bcftools-1.7
#BCFtools
echo "${y}*******************"
echo 'BCFtools'
echo "*******************${w}"

bcf_tools_tar=bcftools-1.9.tar.bz2
bcf_tools_path=bcftools-1.9/
wget https://github.com/samtools/bcftools/releases/download/1.9/bcftools-1.9.tar.bz2
tar xjf  $bcf_tools_tar
cd $bcf_tools_path && ./configure && make -j $threads prefix=/usr/local/bin install && sudo make install -j $threads
sudo ln -s /usr/local/bin/bin/bcftools /usr/bin/bcftools
cd .. && rm -rf $bcf_tools_path $bcf_tools_tar
bcftools_v=`bcftools -v | grep bcftools -A 1`

#HTSLIB
echo "${y}*******************"
echo 'Htslib'
echo "*******************${w}"

HTSLIB_tar=htslib-1.9.tar.bz2
HTSLIB_path=htslib-1.9/
wget https://github.com/samtools/htslib/releases/download/1.9/htslib-1.9.tar.bz2
tar xjf $HTSLIB_tar
cd $HTSLIB_path && ./configure && make -j $threads && sudo make install -j $threads
cd .. && rm -rf $HTSLIB_path $HTSLIB_tar

#mkdir -p samtools/htslib-1.7
#tar -zxf samtools/htslib-1.7.tar.gz -C samtools/htslib-1.7
#samtools/htslib-1.7/configure
#make -j $threads -C samtools/htslib-1.7
#sudo make -j $threads install -C samtools/htslib-1.7
#rm -rf samtools/htslib-1.7

#SAmtools
#mkdir -p samtools/samtools-1.8
#tar -xzf samtools/samtools-1.8.tar.gz -C samtools/samtools-1.8
#./samtools/samtools-1.8/configure
#make -j $threads -C samtools/samtools-1.8
#sudo make -j $threads install -C samtools/samtools-1.8
#rm -rf samtools/samtools-1.8
#rm -rf config.h config.log config.mk config.status Makefile debug lib po src tests Doxyfile libtool stamp-h1 htslib.pc.tmp .cpu.txt htslib.pc.tmp

#SAMTOOLS
echo "${y}*******************"
echo 'Samtools'
echo "*******************${w}"

samtools_path=samtools-1.9/
samtools_bz2=samtools-1.9.tar.bz2
wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2
tar xjf $samtools_bz2
cd $samtools_path && ./configure && make -j $threads && sudo make install -j $threads
cd .. && rm -rf $samtools_path $samtools_bz2
samtools_v=`samtools --version | grep samtools`

#Reinstall BLAST+------------------------------------------
echo "${y}*******************"
echo 'Blast'
echo "*******************${w}"
apt-fast install alien -y -qq
blast_url=ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-*+-1.x86_64.rpm
wget $blast_url
alien -v -d *.rpm
dpkg -i *.deb
rm -rf ncbi-blast-*.rpm ncbi-blast*.deb
blast_v=`blastx -version | grep Package`

#if [ -f blast+.tools/ncbi-blast_2.8.1+-3_amd64.deb ];
#then
#	echo ""
#else
#mkdir -p blast+.tools
#wget https://ufpr.dl.sourceforge.net/project/seqs-extractor/Linux-Debiam/blast%2B.tools/ncbi-blast_2.8.1%2B-3_amd64.deb --directory-prefix=blast+.tools/
#echo	" "
#fi
#Reinstall BLAST+------------------------------------------
#sudo apt-get purge ncbi-blast* -y
#sudo dpkg -i blast+.tools/ncbi-blast_2.8.1+-3_amd64.deb
#sudo rm -rf blast+.tools

sudo cp seqs-extractor.tools/SeqsExtractor-blast-and-extract /usr/local/sbin/SeqsExtractor-blast-and-extract
sudo chmod +x /usr/local/sbin/SeqsExtractor-blast-and-extract

sudo cp seqs-extractor.tools/SeqsExtractor-extract-de-trinity /usr/local/sbin/SeqsExtractor-extract-de-trinity
sudo chmod +x /usr/local/sbin/SeqsExtractor-extract-de-trinity

sudo cp seqs-extractor.tools/SeqsExtractor-extract-from-blast /usr/local/sbin/SeqsExtractor-extract-from-blast
sudo chmod +x /usr/local/sbin/SeqsExtractor-extract-from-blast

sudo cp seqs-extractor.tools/SeqsExtractor-extract-from-misa /usr/local/sbin/SeqsExtractor-extract-from-misa
sudo chmod +x /usr/local/sbin/SeqsExtractor-extract-from-misa

sudo cp seqs-extractor.tools/SeqsExtractor-run-misa-and-extract /usr/local/sbin/SeqsExtractor-run-misa-and-extract
sudo chmod +x /usr/local/sbin/SeqsExtractor-run-misa-and-extract

sudo cp seqs-extractor.tools/SeqsExtractor-customize-misa /usr/local/sbin/SeqsExtractor-customize-misa
sudo chmod +x /usr/local/sbin/SeqsExtractor-customize-misa

sudo cp seqs-extractor.tools/SeqsExtractor-extract-using-txt /usr/local/sbin/SeqsExtractor-extract-using-txt
sudo chmod +x /usr/local/sbin/SeqsExtractor-extract-using-txt

sudo cp seqs-extractor.tools/SeqsExtractor /usr/local/sbin/SeqsExtractor
sudo chmod +x /usr/local/sbin/SeqsExtractor
sudo chmod -f 777 -R /usr/local/sbin/SeqsExtractor

sudo cp misa.tools/misa.pl /usr/local/sbin/misa.pl
sudo cp misa.tools/misa.ini /usr/local/sbin/misa.ini
sudo chmod -f 777 -R /usr/local/sbin/misa.pl
sudo chmod -f 777 -R /usr/local/sbin/misa.ini
sudo chmod +x /usr/local/sbin/misa.pl

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
sudo apt-get purge samtools -y
rm -f /usr/local/bin/samtools
rm -f /usr/local/bin/samtools.pl

#uninstall BLAST+
sudo apt-get purge ncbi-blast+ -y
sudo apt-get purge ncbi-blast -y
sudo rm -rf /usr/local/sbin/SeqsExtractor-blast-and-extract
sudo rm -rf /usr/local/sbin/SeqsExtractor-extract-de-trinity
sudo rm -rf /usr/local/sbin/SeqsExtractor-extract-from-blast
sudo rm -rf /usr/local/sbin/SeqsExtractor-extract-from-misa
sudo rm -rf /usr/local/sbin/SeqsExtractor-run-misa-and-extract
sudo rm -rf /usr/local/sbin/SeqsExtractor-customize-misa
sudo rm -rf /usr/local/sbin/SeqsExtractor-extract-using-txt
sudo rm -rf /usr/local/sbin/SeqsExtractor
				
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

