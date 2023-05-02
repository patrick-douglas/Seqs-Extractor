#!/bin/bash 
w=$(tput sgr0) 
r=$(tput setaf 1)
g=$(tput setaf 2) 
y=$(tput setaf 3) 
USAGE="USAGE: $0 -l <ncbi_accessions_list>"
EXAMPLE_ACC_LST="
Example:
NC_048212
NC_034440
NC_046954
NC_046964
NC_025217
NC_010437
NC_014470
NC_022103
NC_010646
NC_038294"
if [ "$#" -lt "1" ] 
then 
    echo -e $USAGE;
exit 1    
else 
    var1=$2;
fi

while getopts l: option
do
case "${option}"
in
l) acc_lst=$OPTARG;;
esac
done

if [ "$acc_lst" = "" ]; then
echo "${g}Error, missing arguments:${y} -l | NCBI accession list | <string>"
echo "${w}$USAGE"
echo "$EXAMPLE_ACC_LST"
exit 1
fi
num_acc=`cat $acc_lst | wc -l`
echo "====================================="
echo "Total number of seqs to fetch: $num_acc"
echo "====================================="
echo ""
rm -rf .download_$acc_lst.sh
cat $acc_lst | sed -e 's/^/esearch -db nucleotide -query "/' > .download_$acc_lst.sh
sed -e 's/$/" | efetch -format fasta > /' -i .download_$acc_lst.sh
sed ':a;N;$!ba;s/\r//g' -i .download_$acc_lst.sh
cat .download_$acc_lst.sh | awk -F " " '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,"."$5".fa.tmp"}' > .2download_$acc_lst.sh
rm .download_$acc_lst.sh
sed -e 's/$/ \&\& cat /' .2download_$acc_lst.sh | awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$11," >> .main_fasta.tmp.fasta","&& rm "$11}' > .3download_$acc_lst.sh
rm .2download_$acc_lst.sh
chmod +x .3download_$acc_lst.sh
rm -rf .main_fasta.tmp.fasta
#exit 1
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

( ./.3download_$acc_lst.sh ) &
echo -n "> Fetching seqs from NCBI, please wait... "
spinner $!
echo " DONE!"
mv .main_fasta.tmp.fasta $acc_lst.fasta
rm -rf .3download_$acc_lst.sh *.tmp.fa
echo "> Generated a single FASTA file: $acc_lst.fasta"
