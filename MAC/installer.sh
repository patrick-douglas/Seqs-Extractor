#!/bin/bash
#This script can install or unistall Seqs-Extractor in your PC

#Set -j option during make process
echo $USER > .user.tmp
user_name=`cat .user.tmp`

#normal=$(tput sgr0)                      # normal text
normal=$'\e[0m'                           # (works better sometimes)
bold=$(tput bold)                         # make colors bold/bright
red="$bold$(tput setaf 1)"                # bright red text
green=$(tput setaf 2)                     # dim green text
fawn=$(tput setaf 3); beige="$fawn"       # dark yellow text
yellow="$bold$fawn"                       # bright yellow text
darkblue=$(tput setaf 4)                  # dim blue text
blue="$bold$darkblue"                     # bright blue text
purple=$(tput setaf 5); magenta="$purple" # magenta text
pink="$bold$purple"                       # bright magenta text
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan="$bold$darkcyan"                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text




white=$(tput sgr0) 
red=$(tput setaf 1)
green=$(tput setaf 2) 
orange=$(tput setaf 8) 
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [[ $user_name == root ]]; then
echo	"${bold}________________________________________________________________________________"
echo 	""
echo	"_________________________ Seqs-Extractor 0.9 __________________________________"
echo	"________________________________________________________________________________"
echo 	""
	echo ""
   echo "${red}ERROR: THIS SCRIPT MUST NOT BE RUN AS ROOT, please DO NOT use ${white}sudo${red} or ${white}sudo -i${red} to run this script" 1>&2
echo "${green}"

   exit 1
fi

clear


	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ Seqs-Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo "${white}"
	echo    "--------------------------------------------------------------------------------"
	echo    "                         Configuration script                             "
	echo    "--------------------------------------------------------------------------------"
		echo ""
	echo "Choose an option bellow:

${green} 1${white} to install Seqs-Extractor 
${green} 2${white} to uninstall Seqs-Extractor"
		echo "${green}"
		read inst_opt
		echo "${white}"


if [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ]
then
echo "${red}"
while 
read -p 'Try again: ' inst_opt && [ "$inst_opt" != "1" ] && [ "$inst_opt" != "2" ] ; do
echo "${red}
-------------------------------------------------------------
ERROR ${white}$inst_opt${red} IS NOT A VALID OPTION, PLEASE CHOOSE A VALID OPTION!
-------------------------------------------------------------
"
done
fi
if
if [ $inst_opt = "1" ]; then
sudo installer -pkg blast+.tools/ncbi-blast-2.6.0+.pkg -target /
sudo cp seqs-extractor.tools/SeqsExtractor-1.0 /usr/local/bin/seqs-extractor
sudo chmod +x /usr/local/bin/seqs-extractor
sudo chmod -f 777 /usr/local/bin/seqs-extractor
sudo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap homebrew/science
brew install samtools

sudo cp misa.tools/misa.pl /usr/local/bin/
sudo cp misa.tools/misa.ini /usr/local/bin/
sudo chmod +x /usr/local/bin/misa.pl 
sudo chmod -f 777 /usr/local/bin/misa.pl 
fi
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
	exit 1
fi


if [ $inst_opt = "2" ]; then

	if
	[ ! -f /usr/local/bin/seqs-extractor ]
		then
			echo 'Seqs-Extractor already uninstalled!'
 
	elif
		[ -f /usr/local/bin/seqs-extractor ]
		then
		sudo rm -f -r /usr/local/ncbi 
		sudo rm -f -r /usr/local/bin/seqs-extractor
		brew remove samtools
		echo 'Seqs-Extractor UNINSTALLED SUCCESSFULLY!'

		
clear
	echo "${green}"
	echo	"________________________________________________________________________________"
	echo 	""
	echo    "_________________________ Seqs-Extractor 0.9 __________________________________"
	echo	"________________________________________________________________________________"
	echo	""
	echo	"Seqs-Extractor UNINSTALLED SUCCESSFULLY!
"

		fi
fi
rm -rf user.tmp
