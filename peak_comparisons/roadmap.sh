#!/bin/bash

wget -r -l1 --no-parent -nd -A "*DNase.imputed*.gz" https://egg2.wustl.edu/roadmap/data/byFileType/peaks/consolidatedImputed/narrowPeak/

mkdir processed_dnase

for i in `ls -v *DNase*.gz`; do gunzip -c $i > processed_dnase/${i%.*}; done

cd processed_dnase

# Combining all imputed DNase data from Roadmap
# Will be used to generally explore if our mouse-derived human profiles have an evidence of regulatory potential in humans
cat * | sort -k1,1 -k2,2n > sorted_roadmap_imputed_DNase.bed

bedtools --version
bedtools merge -i sorted_roadmap_imputed_DNase.bed > merged_roadmap_imputed_DNase.bed

# Neuropsych/Brain groups from Roadmap
# https://egg2.wustl.edu/roadmap/web_portal/meta.html
# Will be used to ask the same question as above but in a more concerted "brain" context
cat E053-DNase.imputed.narrowPeak.bed.nPk E054-DNase.imputed.narrowPeak.bed.nPk E071-DNase.imputed.narrowPeak.bed.nPk E068-DNase.imputed.narrowPeak.bed.nPk E069-DNase.imputed.narrowPeak.bed.nPk E072-DNase.imputed.narrowPeak.bed.nPk E067-DNase.imputed.narrowPeak.bed.nPk E073-DNase.imputed.narrowPeak.bed.nPk E070-DNase.imputed.narrowPeak.bed.nPk E082-DNase.imputed.narrowPeak.bed.nPk E082-DNase.imputed.narrowPeak.bed.nPk | sort -k1,1 -k2,2n > sorted_roadmap_brain.bed

bedtools --version
bedtools merge -i sorted_roadmap_brain.bed > merged_roadmap_brain_DNase.bed

exit 0
