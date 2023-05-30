#!/bin/bash
#Este script é executado atraves de um script primario
w=$(tput sgr0) 
r=$(tput setaf 1)
g=$(tput setaf 2) 
y=$(tput setaf 3) 
USAGE="USAGE: $0 -b <B2G mapping table txt> -l <goterms.txt> "
if [ "$#" -lt "1" ] 
then 
    echo -e $USAGE;
exit 1    
else 
    var1=$2;
fi

while getopts b:l: option
do
case "${option}"
in
b) b2go_table=$OPTARG;;
l) GO_full_list=$OPTARG;;
esac
done

if [ "$b2go_table" = "" ]; then
"${g}Error, missing arguments:${y} -b | B2G mapping table txt | <string>
${w}$USAGE"
elif [ "$GO_full_list" = "" ]; then
"${g}Error, missing arguments:${y} -l | goterms.txt | <string>
${w}$USAGE"
exit 1
fi
#b2go_table=blast2go_table.txt
#GO_full_list=goterms.txt
b2go_table_name=`echo $b2go_table | awk -F "." '{print $1}'`
cat $b2go_table | awk -F "\t" '{print $6}' | sed -r 's/, /\n/g' > .blast2go_GO_tables.txt

cat $GO_full_list | grep -f .blast2go_GO_tables.txt > $b2go_table_name.GO.full_names.txt
rm .blast2go_GO_tables.txt 
cat $b2go_table_name.GO.full_names.txt

