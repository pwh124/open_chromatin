# Make directory for holding overlap results
mkdir -p overlaps_unique

# Calculate peak counts
wc -l *.bed | sed '$d' | awk '{print $2"\t"$1}' > overlaps_unique/tmp_peak_counts.txt
echo -e filename"\t"total.peaks | cat - overlaps_unique/tmp_peak_counts.txt > overlaps_unique/hg19_peak_counts.txt
rm overlaps_unique/tmp_peak_counts.txt

# Reference .bed locations
boca=/Volumes/PAULHOOK/2019_open-chromatin/human_chromatin/boca_atac/boca_processed/merged_boca_neurons.bed
roadmap=/Volumes/PAULHOOK/2019_open-chromatin/human_chromatin/roadmap_dnase/processed_dnase/merged_roadmap_imputed_DNase.bed
brain_roadmap=/Volumes/PAULHOOK/2019_open-chromatin/human_chromatin/roadmap_dnase/processed_dnase/merged_roadmap_brain_DNase.bed
combined=/Volumes/PAULHOOK/2019_open-chromatin/human_chromatin/merged_roadmap_boca.bed

#Overlap all with boca
touch overlaps_unique/boca_peak_overlap.txt
echo -e filename"\t"boca.count >> overlaps_unique/boca_peak_overlap.txt
for i in `ls -v *.bed`
do
count=`bedtools intersect -wa -a $i -b $boca | uniq | wc -l`
echo -e $i"\t"$count >> overlaps_unique/boca_peak_overlap.txt
done

#Overlap all with roadmap
touch overlaps_unique/roadmap_peak_overlap.txt
echo -e filename"\t"roadmap.count >> overlaps_unique/roadmap_peak_overlap.txt
for i in `ls -v *.bed`
do
count=`bedtools intersect -wa -a $i -b $roadmap | uniq | wc -l`
echo -e $i"\t"$count >> overlaps_unique/roadmap_peak_overlap.txt
done

#Overlap with roadmap brain
touch overlaps_unique/brain_roadmap_peak_overlap.txt
echo -e filename"\t"brain.roadmap.count >> overlaps_unique/brain_roadmap_peak_overlap.txt
for i in `ls -v *.bed`
do
count=`bedtools intersect -wa -a $i -b $brain_roadmap | uniq | wc -l`
echo -e $i"\t"$count >> overlaps_unique/brain_roadmap_peak_overlap.txt
done

#Overlap with all
touch overlaps_unique/combined_peak_overlap.txt
echo -e filename"\t"combined.count >> overlaps_unique/combined_peak_overlap.txt
for i in `ls -v *.bed`
do
count=`bedtools intersect -wa -a $i -b $combined | uniq | wc -l`
echo -e $i"\t"$count >> overlaps_unique/combined_peak_overlap.txt
done

exit 0