#!/bin/sh

mkdir -p final_results

while read -r line;
do
echo ${line}
./combine.sh ${line}
done < results_list.txt

cd final_results

awk 'FNR==1 && NR!=1{next;}{print}' *.txt > all_h2_results.txt


exit 0
