# Calculate peak counts
wc -l *.bed | sed '$d' | awk '{print $2"\t"$1}' > tmp_peak_counts.txt
echo -e filename"\t"total.peaks | cat - tmp_peak_counts.txt > cd4_peak_counts.txt
rm tmp_peak_counts.txt

# make an output file
touch cd4_peak_overlap.txt
echo -e human.mouse"\t"filename"\t"cd4.count >> cd4_peak_overlap.txt

# overlaps
a=summits_filter2_cd4_mm10_merged_GSE107076_summits.bed

# ATAC
b=final_CD4-summits_corces_hg19_summits.bed
name="ATAC.human"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

# Naive roadmap. Not republished on Zenodo as this data exists
b=cd4.naive_dnase.roadmap.bed
name="naive.roadmap"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

# Memory roadmap. No republished on Zenodo as this data exists
b=cd4.memory_dnase.roadmap.bed
name="memory.roadmap"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

# Combined ATAC/roadmap
b=merged_cd4_atac.roadmap.bed
name="combined.atac.roadmap"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

# All roadmap
b=merged_roadmap_imputed_DNase.bed
name="all.roadmap"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

# All roadmap plus ATAC
b=all.roadmap_cd4_atac.bed
name="all.roadmap.plus.atac"
count=`bedtools intersect -wa -a $a -b $b | uniq | wc -l`
echo -e $a"\t"$b"\t"$name"\t"$count >> cd4_peak_overlap.txt

exit 0
