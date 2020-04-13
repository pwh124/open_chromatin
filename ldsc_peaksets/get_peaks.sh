#!/bin/sh

# Download peaks and unzip
wget -nc https://zenodo.org/record/3253181/files/hg19_final_peaks.tar.gz
tar --keep-old-files -xvzf hg19_final_peaks.tar.gz

## Remove tar
rm hg19_final_peaks.tar.gz

## check bedtools version (v2.24.0)
bedtools --version

## Make directories
mkdir -p distal
mkdir -p prom
mkdir -p minus
mkdir -p unique

## Move into final peak directory
cd hg19_final_peaks

# distal peaks
for i in `ls -v *bed`
do bedtools intersect -wa -v -a $i -b ../hg19_promoters/hg19_promoter_500.bed | uniq > ../distal/distal_${i}
done

# promotor peaks
for i in `ls -v *bed`
do bedtools intersect -wa -a $i -b ../hg19_promoters/hg19_promoter_500.bed | uniq > ../prom/prom_${i}
done

# minus the top annotation peaks
for i in `ls -v *bed`
do bedtools intersect -wa -v -a $i -b summits_filter2_ex3_merge_preissl_summits.bed | uniq > ../minus/minus_${i}
done

# unique peaks
## renaming files so they are easier to work with and creating a metadata list
## Turned out not to be easier to work with.
ls -v | cat -n > ../unique/bedList.txt
ls -v | cat -n | while read n f; do mv -n "$f" ../unique/"$n.bed"; done

## go into unique directory
cd ../unique/

## add the file names to the 4th column of the files and rename
for i in `ls -v *.bed`; do awk 'BEGIN{OFS="\t";}{print $0,FILENAME}' $i > mod_${i}; done

## cat all the files and sort
cat mod*.bed | sort -k1,1 -k2,2n > sort_cat_beds.bed

## Merge the files and have it be required that there is at least 1 bp overlap (no bookend). Collapse the file names and separate by comma. This creates a bed file where "unique" peaks are the ones that don't interset with any other annotations
bedtools merge -i sort_cat_beds.bed -d -1 -c 4 -o collapse > collapsed.bed

## Only keep lines with no comma (unique peaks)
grep -v "," collapsed.bed > total_unique.bed

## For the files 1-27, grep peaks with that file name in the 4th column and print to new file
for i in {1..27}; do grep -w "${i}.bed" total_unique.bed > unique_${i}.bed; done

## remove intermediates
rm mod*


