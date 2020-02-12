#!/bin/sh

#Import directory name
dir=$1

#Go into that directory
cd $dir

#Save directory name
col=`pwd | awk -F/ '{print $NF}'`

#Obtaining the h2 and appending pheotype name on the data
grep "Total Observed scale h2" *.log | awk -F'[:|(|)]' -v OFS="\t" -v col="$col" '{print $1,$3,$4,col}' | sed 's/.log//g' > ${col}_h2.txt
echo -e "sample1\th2\th2_se\tpheno" | cat - ${col}_h2.txt > final_${col}_h2.txt

#Obtaining # of SNPs in each analysis
grep "SNPs with chi" *.log | awk -F'[:|(|)| ]' -v OFS="\t" '{print $1,$10}' | sed 's/.log//g' > ${col}_snps.txt
echo -e "sample2\tn_snps" | cat - ${col}_snps.txt > final_${col}_snps.txt

#Obtaining the rsults for each cell-type
grep "^L2_0" *.results | sed 's/.results:L2_0//g' > ${col}_results.txt
head -1 summits_filter2_blue-cone_ss-all_merge_GSE83312_summits.results | cat - ${col}_results.txt > final_${col}_results.txt

#Pasting
paste final_${col}_h2.txt final_${col}_snps.txt final_${col}_results.txt > total_${col}_results.txt

#Copying to common directory
cp total* ../final_results

exit 0
