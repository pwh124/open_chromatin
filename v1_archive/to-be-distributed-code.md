### Merging replicates
```bash
FILE1=$1
FILE2=$2
FILE3=$3
NAME=$4

module load samtools

samtools merge -@ 15 ../../../final_mm10_alignments_5-4-18/${NAME}.bam ${FILE1} ${FILE2} ${FILE3}

cd ../../../final_mm10_alignments_5-4-18/

samtools sort -@ 15 -o sorted_${NAME}.bam ${NAME}.bam
samtools index sorted_${NAME}.bam
```

### Calling peaks
```shell
TMPDIR=$HOME/tmp

module load use.own
module load macs2

cd merged/

for i in `ls -v sorted*bam`
do
macs2 callpeak --nomodel --shift -100 --extsize 200 --keep-dup all --gsize mm  -t $i -n shift_ext_${i%.bam} --outdir ../../called_peaks/merged_peaks_shift-ext_7-3-18
done

exit 0
```

### Making count matrix
```shell
cat *narrowPeak > atac_all_cells.narrowPeak
sort -k1,1 -k2,2n atac_all_cells.narrowPeak > sorted_atac_all_cells.bed

module load gcc/5.4.0 
module load bedtools/2.27

bedtools merge -i sorted_atac_all_cells.bed -c 4 -o collapse,count > merged_sorted_atac_all_cells.bed

bedtools intersect -a merged_sorted_atac_all_cells.bed -b ../../blacklists/mm10_atac-encode_blacklist.bed -v > cleaned_merged_sorted_atac_all_cells.bed

wc -l *bed > peak_counts.txt

awk '{print $1,$2,$3}' cleaned_merged_sorted_atac_all_cells.bed | awk '$4=(FS"peak_"FNR)' | awk '$5=(FS"+")' | awk -v OFS='\t' '{print $4,$1,$2,$3,$5}' > cleaned_merged_sorted_atac_all_cells_tmp.SAF

#Use text editor to add the appropriate header
nano -w cleaned_merged_tmp.SAF 
# added 'GeneID	Chr	Start	End	Strand`
#from http://bioinf.wehi.edu.au/featureCounts/

head cleaned_merged_sorted_atac_all_cells.SAF
GeneID	Chr	Start	End	Strand
peak_1	chr1	3008663	3008863	+
peak_2	chr1	3012568	3012876	+
peak_3	chr1	3026759	3026959	+
peak_4	chr1	3061162	3061362	+
peak_5	chr1	3064416	3064655	+
peak_6	chr1	3066130	3066330	+
peak_7	chr1	3094429	3095804	+
peak_8	chr1	3097165	3097365	+
peak_9	chr1	3097568	3097768	+

~/privatemodules/subread/subread-1.6.1/bin/featureCounts -T 20 -F SAF -a cleaned_merged_atac-peaks.SAF -o test_counts-SE.txt ../../final_mm10_alignments_5-4-18/merged/sorted*bam

awk -v OFS='\t' '{print $2,$3,$4,$1}' cleaned_merged_sorted_atac_all_cells.SAF | tail -n +2 > all_atac_GC_peaks.txt

bedtools nuc -fi ../../fasta/ucsc_goldenpath_mm10.fa -bed all_atac_GC_peaks.txt > GC_peaks.bed

```

### Moving in to R

### liftOver 
*Convert to a BED file that can be easily lifted over*
```shell
awk -v OFS='\t' '{print $1,$2,$3,$4}' shift_ext_sorted_cd8_mm10_merged_GSE107076_peaks.narrowPeak > ../../liftover/mm10_beds/shift_ext_sorted_cd8_mm10_merged_GSE107076_peaks.bed
```
*liftOver from mm10 to hg19*
```shell
$HOME/privatemodules/liftOver.1 -minMatch=0.1 ${i} $OUTDIR1/mm10ToHg19.over.chain.gz $OUTDIR3/${i%.bed}_hg19_10.bed $OUTDIR3/${i%.bed}_hg19_unlifted_10.bed

#beds then cleaned (remove blacklist) and to ldsc directory
```

#making annot files for ldsc
```shell
for chr in {1..22}
do 
python ~/my-python-modules/ldsc/make_annot.py \
--bed-file cd8_merged_GSE107076_hg19.bed \
--bimfile ../../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr}.bim \
--annot-file cd8_merged_GSE107076_hg19.${chr}.annot.gz
done
```
