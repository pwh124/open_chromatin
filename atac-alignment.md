#Alignment
## Introduction

This is my attempt to start documenting the command line code I am using to process publicly available mouse ATAC-seq data.

I will hopefully be breaking this into scripts to then load on to GitHub for reproducibility.

Almost all of these commands were performed on the MARCC server cluster through JHU.

## Dependencies
###Command line 
[samtools v1.3.1](https://github.com/samtools/samtools/releases/tag/1.3.1), [samtools v0.1.19](https://github.com/samtools/samtools/releases/tag/0.1.19), [bowtie2 v2.2.5](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

###Python 
None

###R  
None

##Rough directory structure
``` 
GSE{someNumber}_data    
|-- download  
|		align.sh  
|		fastq_files  
|-- mm10_alignment_results  
|		.bam_files  
|		.bai_files  
|		flagstats  
|		final_align 
```
## Code
###Aligning
*Setting up variables*  

```bash
DIR='/home-3/phook2@jhu.edu/data/PWH/public_atac_data/atac-data/GSE79816_data/download'
FILENAME=$1
INDEX='/home-3/phook2@jhu.edu/work/bowtie_indexes/mm10'
SEQ1=${FILENAME}_1
SEQ2=${FILENAME}_2
NAME=$2

echo $INDEX
echo "Variables set up!"

# Making working directory
cd $DIR
echo "Working directory set!"
```
*Unzipping and aligning reads*

```bash
# Unzipping .fastq.gz files
gunzip ${SEQ1}.fastq.gz
gunzip ${SEQ2}.fastq.gz
echo "Sequencing unzipped"

# Loading bowtie2
module load bowtie2 # v2.2.5

date

bowtie2 -p 15 --local -X2000 -x /home-3/phook2@jhu.edu/work/bowtie_indexes/mm10 -1 ${SEQ1}.fastq -2 ${SEQ2}.fastq  -S ../mm10_align_4-30-18/${NAME}_mm10_aligned.sam

echo "Alignment finished!"
date
```
### Filtering
*Obtaining flagstats and removing reads aligning to mitochonrial, random, and unknown chromosomes*

```bash
cd ../mm10_align_4-30-18

module load samtools/1.3.1
samtools flagstat ${NAME}_mm10_aligned.sam > flagstats/${NAME}_mm10_aligned.sam.flagstat.txt

# Checking alignments
echo "wc -l aligned"
wc -l ${NAME}_mm10_aligned.sam

echo "wc -l chrM"
grep chrM ${NAME}_mm10_aligned.sam | wc -l

echo "wc -l chrUn"
grep chrUn ${NAME}_mm10_aligned.sam | wc -l

echo "wc -l random"
grep random ${NAME}_mm10_aligned.sam | wc -l

# Removing mitochondria, random, and unknown chromosomes
sed '/chrM/d;/random/d;/chrUn/d' < ${NAME}_mm10_aligned.sam > ${NAME}_mm10_removedchrs.sam
```

### Sorting, converting to BAM, and indexing
```bash 
samtools view -@ 15 -bu ${NAME}_mm10_removedchrs.sam | samtools sort -@ 15 -o sorted_${NAME}_mm10.bam

rm ${NAME}_mm10_aligned.sam
rm ${NAME}_mm10_removedchrs.sam

samtools index sorted_${NAME}_mm10.bam

# Get flagstats for filtered BAM files
samtools flagstat sorted_${NAME}_mm10.bam > flagstats/sorted_${NAME}_mm10.flagstat.txt
```
### Removing duplicated reads
```bash
# Removing duplicated reads with older version of samtools
module load samtools/0.1.19
samtools rmdup sorted_${NAME}_mm10.bam rmdup_sorted_${NAME}_mm10.bam

# Getting stats from completely filtered
module load samtools/1.3.1
samtools flagstat rmdup_sorted_${NAME}_mm10.bam > flagstats/rmdup_sorted_${NAME}_mm10.bam.flagstat.txt
```
### Removing improperly paired reads
```bash
echo "Improperly paired reads:"
samtools view -F 0x2 rmdup_sorted_${NAME}_mm10.bam | wc -l

echo "Properly pair reads:"
samtools view -f 0x2 rmdup_sorted_${NAME}_mm10.bam | wc -l

samtools view -f 0x2 -b rmdup_sorted_${NAME}_mm10.bam > pp_rmdup_sorted_${NAME}_mm10.bam

samtools flagstat pp_rmdup_sorted_${NAME}_mm10.bam > flagstats/final_${NAME}_flagstats.txt

samtools index pp_rmdup_sorted_${NAME}_mm10.bam
```

###Removing reads with mapq <= 30
```bash
mkdir final_alignq

module load samtools

# Filtering
for i in `ls -v pp*.bam`
do samtools view -@ 10 -b -q 30 $i > final_align/mapq_${i}
done

# Counting
for i in `ls -v pp*P1*.bam`
do
samtools view -@ 10 -q 30 -c $i
done

```

###Merging replicates
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

###Calling peaks
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

###Making count matrix
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

###Moving in to R

###liftover
```shell
#convert to bed that can be lifted over
awk -v OFS='\t' '{print $1,$2,$3,$4}' shift_ext_sorted_cd8_mm10_merged_GSE107076_peaks.narrowPeak > ../../liftover/mm10_beds/shift_ext_sorted_cd8_mm10_merged_GSE107076_peaks.bed

#lifting over
$HOME/privatemodules/liftOver.1 -minMatch=0.1 ${i} $OUTDIR1/mm10ToHg19.over.chain.gz $OUTDIR3/${i%.bed}_hg19_10.bed $OUTDIR3/${i%.bed}_hg19_unlifted_10.bed

#beds then cleaned (remove blacklist) and to ldsc directory

#making annot files for ldsc
for chr in {1..22}; do python ~/my-python-modules/ldsc/make_annot.py --bed-file cd8_merged_GSE107076_hg19.bed --bimfile ../../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr}.bim --annot-file cd8_merged_GSE107076_hg19.${chr}.annot.gz; done






