
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

while getopts b:l:f: option
do
case "${option}"
in
b) b2go_table=$OPTARG;;
l) GO_full_list=$OPTARG;;
f) term_filter=$OPTARG;;
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

cat $b2go_table | sed '/SeqName/d' | grep GO | awk -F "\t" '{print $3,$10}' | sed -r 's/P://g' | sed -r 's/C://g' | sed -r 's/F://g' | sed -r 's/; /\n/g' | sed -r 's/ /\n/g' > .blast2go_GO_tables.txt
csplit -s -f .Seq -z .blast2go_GO_tables.txt /TRINITY/ '{*}'

for f in .Seq*
    do
    f1=$(head -n1 "$f")
    mv -n "$f" "$f1"
    done

for f in TRINITY*
    do
    sed -i '1d' "$f"
    done

for f in TRINITY*
    do
    awk '{print FILENAME (NF?" ":"") $0}' "$f" > $f.ids
    done
cat *.ids > .blast2go_GO_tables.txt 
rm -rf TRINI* .Seq*
sed -i -r 's/ /\t/g' .blast2go_GO_tables.txt

b2g_go=`cat .blast2go_GO_tables.txt | awk '{print $2}'`
cat $GO_full_list | grep "$b2g_go" > $b2go_table_name.GO.full_names.txt
cat $b2go_table_name.GO.full_names.txt | awk -F "\t" '{print $1}'> $b2go_table_name.GO.IDs.txt

#
if [ "$term_filter" = "" ]; then
cat $b2go_table_name.GO.full_names.txt
else
cat $b2go_table_name.GO.full_names.txt | grep $term_filter > .term_filter.txt
cat .blast2go_GO_tables.txt | grep -f .term_filter.txt
cat .term_filter.txt
cat .term_filter.txt > $b2go_table_name.GO.full_names.terms.filtered.txt
cat .term_filter.txt | awk -F "\t" '{print $1}' > $b2go_table_name.GO.IDs.terms.filtered.txt
fi
rm -rf .term_filter.txt .blast2go_GO_tables_2-1.txt .blast2go_GO_tables.txt















