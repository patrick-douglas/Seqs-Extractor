#!/bin/bash
w=$(tput sgr0) 
r=$(tput setaf 1)
g=$(tput setaf 2) 
y=$(tput setaf 3) 
S=`basename $0`
USAGE="USAGE:
${g}Example:${w} $S -i <input_dataset> -n <5> -r <10>
Required arguments: 
-i <string> | data set
-n <int>    | number of lines to get 
-r <int>    | number of relicates to get"

while getopts i:n:r: option
do
case "${option}"
in
i) db_original=${OPTARG};;
n) num_lines=$OPTARG;;
r) num_repli=$OPTARG;;
esac
done

if [ "$db_original" = "" ]; then
echo "${g}Error, missing arguments:${y} -i | input dataset | <string>"
echo "$USAGE"
exit 1
fi
if [ "$num_lines" = "" ]; then
echo "${g}Error, missing arguments:${y} -n | number of lines to get | <int>"
echo "$USAGE"
exit 1
fi
if [ "$num_repli" = "" ]; then
echo "${g}Error, missing arguments:${y} -r | number of replicates to create | <int>"
echo "$USAGE"
exit 1
fi
echo "${y}_________________________________"
echo "Random population generator v-1.0"
echo "_________________________________${g}"
echo ''
echo "${g}---------------------------------"
echo "Input dataset:"
echo "---------------------------------${w}"
echo "$db_original"
echo ''
echo "${g}---------------------------------"
echo "Number of samples:"
echo "---------------------------------${w}"
echo "$num_lines"
echo ''
echo "${g}---------------------------------"
echo "Number of replicates:"
echo "---------------------------------${w}"
echo "$num_repli"
echo "${g}---------------------------------"

sed '1d' $db_original > .db_input
cat .db_input | grep -B999 Pop > .pop
sed -i '$ d' .pop
num_pop=`cat .db_input | grep -B999 Pop -i | wc -l`
pop_num=`expr $num_pop - 1`
sed -i "1,$pop_num d" .db_input
sed -i '/Pop/d' .db_input
#test if .db_input have enogh samples according to $num_lines
max_samp=`cat .db_input | wc -l`
if [ $num_lines -gt $max_samp ]
    then
    echo "${y}"
    echo "------------------------------------------------------------------------------------------------"
    echo " ${y}Error, the maximum number of samples is${w} $max_samp${y}, change the parameter -n to a value less or equal ${w}$max_samp"
    echo "${y}------------------------------------------------------------------------------------------------"
    echo "${w}"
    rm -rf .01.sh .temp.sh *.locus .sed.sh .pop .db_input
    exit 1
    else
    echo ''
fi

echo '#!/bin/bash' > .temp.sh
echo 'file="$1"' >> .temp.sh
echo "shuf -n $num_lines .db_input > \$file" >> .temp.sh
chmod +x .temp.sh
echo "touch {1..$num_repli}.replica.txt" > .01.sh
chmod +x .01.sh
./.01.sh
for file in *.replica.txt; do ./.temp.sh "$file"; done
num_coll=`head -n1 .db_input | grep -o " " | wc -l`
sed -i "1 i Pop" *.replica.txt
#echo "touch {1..$num_coll}.locus" > .01.sh
chmod +x .01.sh
./.01.sh
echo '#!/bin/bash' > .sed.sh
echo 'file="$1"' >> .sed.sh
echo 'sed -i "1 i $file" *.replica.txt' >> .sed.sh
chmod +x .sed.sh
#for file in *.locus; do ./.sed.sh "$file"; done
sed -i "1 i .db_input" *.replica.txt
mkdir -p $num_lines 
sed -i '1d' *.txt
sed -i -e '2{x;G};1{h;r.pop' -e 'd}' *.replica.txt
mv *.replica.txt $num_lines
sed -i '1 i\Title line:""' $num_lines/*.txt
rm -rf .01.sh .temp.sh *.locus .sed.sh .pop .db_input
