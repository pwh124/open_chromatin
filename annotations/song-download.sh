#!/bin/bash

# Downloading Excel sheet of significant interactions in each cell type from Song 2019
wget --no-clobber https://static-content.springer.com/esm/art%3A10.1038%2Fs41588-019-0472-1/MediaObjects/41588_2019_472_MOESM4_ESM.xlsx

# pip install xlsx2csv - install this if needed

# Processing Excel sheets to text files for individual cell types
xlsx2csv -d 'tab' -s1 41588_2019_472_MOESM4_ESM.xlsx | tail -n +3 | sed 's/ /./g' | awk 'BEGIN{FS=OFS="\t"};{print $1","$2","$3,$5","$6","$7,$9,$10,$11,$12,$13,$14,$15,$17,$18,$19,$20}' > song_excitatory_hic.tsv

xlsx2csv -d 'tab' -s2 41588_2019_472_MOESM4_ESM.xlsx | tail -n +3 | sed 's/ /./g' | awk 'BEGIN{FS=OFS="\t"};{print $1","$2","$3,$5","$6","$7,$9,$10,$11,$12,$13,$14,$15,$17,$18,$19,$20}' > song_hippocampus_hic.tsv

xlsx2csv -d 'tab' -s3 41588_2019_472_MOESM4_ESM.xlsx | tail -n +3 | sed 's/ /./g' | awk 'BEGIN{FS=OFS="\t"};{print $1","$2","$3,$5","$6","$7,$9,$10,$11,$12,$13,$14,$15,$17,$18,$19,$20}' > song_motor_hic.tsv

xlsx2csv -d 'tab' -s4 41588_2019_472_MOESM4_ESM.xlsx | tail -n +3 | sed 's/ /./g' | awk 'BEGIN{FS=OFS="\t"};{print $1","$2","$3,$5","$6","$7,$9,$10,$11,$12,$13,$14,$15,$17,$18,$19,$20}' > song_astro_hic.tsv

# Start R script processing the results
Rscript process-Song.R

# Wait until a file appears. This works because the completed file in coming from the Rscript, not from a real-time linux command
while [ ! -f ./song_all.interactions.bed ]; do sleep 1; done

# After file appears, do bedintersect
bedtools intersect -wa -wb -a pip.overlap.snps.bed -b song_all.interactions.bed > snp-hic-interactions.txt

# Cut down all song interactions so it can be visualized on WashU

cat song_all.interactions.bed | awk 'BEGIN{FS=OFS="\t"};{print $1,$2,$3,$4","5}' | sort -k1,1 -k2,2n > WASHU_song-all.interactions.txt
bgzip WASHU_song-all.interactions.txt
tabix -p bed WASHU_song-all.interactions.txt.gz

# Work on visualizing all the cells interactions
for i in `ls -v WASHU*song.txt`
do 
sort -k1,1 -k2,2n $i > sorted_${i}
bgzip sorted_${i}
tabix -p bed sorted_${i}.gz
done

exit 0

# These can be further limited to certain loci