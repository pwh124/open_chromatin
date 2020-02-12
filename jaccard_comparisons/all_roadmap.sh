#!/bin/bash

# Downloading script from Aaron Quinlan to make a matrix from http://quinlanlab.org/tutorials/bedtools/bedtools.html#a-jaccard-statistic-for-all-400-pairwise-comparisons.
wget --no-clobber https://s3.amazonaws.com/bedtools-tutorials/web/make-matrix.py

# Download the final hg19 peaks used in the paper
wget --no-clobber https://zenodo.org/record/3253181/files/hg19_final_peaks.tar.gz

# Unziping
tar -xvzf hg19_final_peaks.tar.gz

# Make a directory for the promoter data
mkdir -p all

# Moving peak files into directory

cp hg19_final_peaks/*.bed all/

# Switch to promoter directory
cd all

# Downloading the bed files
wget -r -l1 --no-parent -nd -A "*DNase.imputed*.gz" https://egg2.wustl.edu/roadmap/data/byFileType/peaks/consolidatedImputed/narrowPeak/

# Unzipping everything
gunzip *.gz
rm *.gz

# Changing extension to match .bed
rename -vs ".nPk" "" *

# sorting the bed files
for i in `ls -v *.bed`; do sort -k1,1 -k2,2n $i > sorted_${i}; done

# removing unsorted files
rm E*narrowPeak.bed final*.bed summits*.bed

# Making a directory for Jaccard results
mkdir -p jaccard

# Running parallel bedtools jaccard
parallel "bedtools jaccard -a {1} -b {2} | awk 'NR>1' | cut -f 3 > jaccard/{1}.{2}.jaccard" ::: `ls sorted*` ::: `ls sorted*`

# Going into Jaccard dir
cd jaccard

find . | grep jaccard | xargs grep "" | sed -e s"/\.\///" | perl -pi -e "s/.bed./.bed\t/"  | perl -pi -e "s/.jaccard:/\t/"  > all_pairwise.dnase.txt

cat all_pairwise.dnase.txt | sed -e "s/sorted_summits_filter2_//g" | sed -e "s/_summits.bed//g" | sed -e "s/sorted_//g" | sed "s/imputed.narrowPeak.bed//g" > mod_all_pairwise.dnase.txt

awk 'NF==3' mod_all_pairwise.dnase.txt | python ../../make-matrix.py > all.matrix

exit 0
