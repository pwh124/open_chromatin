:## Scoring and filtering summits according to what was laid out in TCGA ATAC-seq paper which normalizes peakScore for sequencing depth. We wanted to do this so that peaks that meet the same level of evidence in each cell population would be used.

## Starting with summit beds from MACS2 that are arranged as follows
## chr	start	end	peak_name	peakScore
## peakScore is the pileup at the summit which is the -log10(p-value)

## Calculate normalized peakScore using a for loop. First save a variable that is the sum of the peakScore (sum) and then divide that number by 1000000. Then divide the peakScore column by the sum/1000000 to get the normalized peakScore per million.
for i in `ls -v shift*summits.bed`; do sum=`cat $i | awk '{sum += $5} END {print sum/1000000}'`; awk -v var="$sum" '{print $0"\t"$5/var}' $i > score_${i}; done

## Sort summits and remove mm10 blacklisted regions using bedtools
for i in `ls -v score*`; do cat $i | sort -k1,1 -k2,2n | bedtools intersect -sorted -a - -b ../../blacklists/sorted_mm10.blacklist.bed -v > cleaned_${i}; done

## This leaves us with peak files with the following columns
## chr	start	end	peak_name	peakScore	normalized_peakScore

## Now we want to filter on normalized_peakScore. These filtered bed files are placed in a directory called "filtered_2"
for i in `ls -v cleaned*`; do awk '$6 >= 2 {print $0}' $i > filtered_2/filter2_${i}; done

## Now we clean up the file names. This was done because many prefixes are added to the files as the analysis goes on
rename "filter2_cleaned_score_shift_ext_" "" *
rename "sorted_" "" *
rename "mm10_merged_" "" *
rename "merge_" "" *

## Summits can then be used going forward. Human peaks from CD4/CD8 T-cells were processed in the same way