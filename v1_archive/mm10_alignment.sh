#!/bin/bash

#SBATCH --job-name=alignment
#SBATCH --time=08:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=15
#SBATCH --mem=50G
#SBATCH --mail-type=end
#SBATCH --mail-user='ENTER EMAIL HERE'

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

echo "Begin by setting up software."
source ~/.bash_profile
echo $BT2_path # path to bowtie2 v2.2.5
echo $rmdup_path # path to samtools 0.1.19 which contains rmdup that actually works
echo $samtools_path # path to samtools 1.3.1 for all other samtools functions

## The directories for the alignment will need to be set up for each different project from which sequencing will be aligned. This will require that this script is copied and modified for the specific sequencing. See the description of the file directory set up in 'Alignment.md." $MAIN_DIR should remain invariant. $PROJECT_NAME (which is the name of the project directory) should change with each publicly available dataset analyzed.

MAIN_DIR='ENTER MAIN DIRECTORY HERE'
INDEX_DIR='ENTER DIRECTORY CONTAINING BOWTIE2 INDICES HERE'

PROJECT_NAME='GSE107076_Tcells'
DOWNLOAD_DIR=$MAIN_DIR/$PROJECT_NAME/download

## This script is set up in such a way that it will take arguments from the command line. Including the prefix of the sequencing files to be aligned ($FILENAME) usually in the form of something like this: "SRRXXXXXXX". It will also take the prefix of the output files ($NAME).

FILENAME=$1
NAME=$2
SEQ1=${FILENAME}_1
SEQ2=${FILENAME}_2

## Now I want to echo everything so we will know it is set up correctly

echo "This is your directory containing downloaded FASTQ files: $DOWNLOAD_DIR"
echo "This is your directory containing the Bowtie2 index: $INDEX_DIR"
echo "This is your input file name prefix: $FILENAME"
echo "This is your output file name prefix: $NAME"

## Change working directory to download folder
cd $DOWNLOAD_DIR

## Unzipping .fastq.gz files. If already unzipped, there will be a short error message thrown.
gunzip ${SEQ1}.fastq.gz
gunzip ${SEQ2}.fastq.gz

echo "$FILENAME sequencing is unzipped"

## Aligning sequencing to mm10. These settings are suggested for aligning ATAC-seq reads in our lab. See McClymont et al.
$BT2_path/bowtie2 -p 15 --local -X2000 -x $INDEX_DIR/mm10 -1 ${SEQ1}.fastq -2 ${SEQ2}.fastq  -S ../mm10_align/${NAME}_mm10_aligned.sam

echo "Alignment to mm10 finished!"

## Changing directory to where the alignments were sent. Again this follows a strict directory setup. 
cd ../mm10_align

## Obtaining alignment stats
$samtools_path/samtools flagstat ${NAME}_mm10_aligned.sam > flagstats/${NAME}_mm10_aligned.sam.flagstat.txt

## Check numbers for all the alignments. We especially want to know about mitochondrial (chrM), unknown (chrUn), and random alignments, as we will want to remove them.
echo "wc -l aligned"
wc -l ${NAME}_mm10_aligned.sam

echo "wc -l chrM"
grep chrM ${NAME}_mm10_aligned.sam | wc -l

echo "wc -l chrUn"
grep chrUn ${NAME}_mm10_aligned.sam | wc -l

echo "wc -l random"
grep random ${NAME}_mm10_aligned.sam | wc -l

## Removing alignments to those chromosomes
sed '/chrM/d;/random/d;/chrUn/d' < ${NAME}_mm10_aligned.sam > ${NAME}_mm10_removedchrs.sam

## Using samtools to convert .sam to a sorted .bam
$samtools_path/samtools view -@ 15 -bu ${NAME}_mm10_removedchrs.sam | $samtools_path/samtools sort -@ 15 -o sorted_${NAME}_mm10.bam

## Cleaning up large .sam files
rm ${NAME}_mm10_aligned.sam
rm ${NAME}_mm10_removedchrs.sam

## Indexing the .bam file
$samtools_path/samtools index sorted_${NAME}_mm10.bam

## Using samtools to obtain the flagstats for the processed .bam files
$samtools_path/samtools flagstat sorted_${NAME}_mm10.bam > flagstats/sorted_${NAME}_mm10.flagstat.txt

## Using the older version of samtools in order to remove duplicate reads
$rmdup_path/samtools rmdup sorted_${NAME}_mm10.bam rmdup_sorted_${NAME}_mm10.bam

## Using samtools to obtain flagstats after duplicate removal
$samtools_path/samtools flagstat rmdup_sorted_${NAME}_mm10.bam > flagstats/rmdup_sorted_${NAME}_mm10.bam.flagstat.txt

## Checking for improperly/properly paired reads and removing them
echo "Improperly paired reads:"
$samtools_path/samtools view -F 0x2 rmdup_sorted_${NAME}_mm10.bam | wc -l

echo "Properly pair reads:"
$samtools_path/samtools view -f 0x2 rmdup_sorted_${NAME}_mm10.bam | wc -l

$samtools_path/samtools view -f 0x2 -b rmdup_sorted_${NAME}_mm10.bam > pp_rmdup_sorted_${NAME}_mm10.bam

## Running flagstats again in order to get "final" stats
$samtools_path/samtools flagstat pp_rmdup_sorted_${NAME}_mm10.bam > flagstats/final_${NAME}_flagstats.txt

## Indexing the "final" bam file
$samtools_path/samtools index pp_rmdup_sorted_${NAME}_mm10.bam

## Removing reads reads with a MAPQ <30
$samtools_path/samtools view -@ 15 -b -q 30 pp_rmdup_sorted_${NAME}_mm10.bam > final_align/mapq_pp_rmdup_sorted_${NAME}_mm10.bam

## Indexing final final bam file
$samtools_path/samtools index final_align/mapq_pp_rmdup_sorted_${NAME}_mm10.bam
$samtools_path/samtools flagstat final_align/mapq_pp_rmdup_sorted_${NAME}_mm10.bam > flagstats/mapq_pp_rmdup_${NAME}.flagstats.txt

exit 0
