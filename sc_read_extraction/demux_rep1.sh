#!/bin/bash

#SBATCH --job-name=demultiplex-1
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --mail-type=end
#SBATCH --partition=shared
#SBATCH --mail-user=pwh124@gmail.com

source ~/.bash_profile
module load java

# Move into the directory where the sequencing was downloaded
DIR=/home-3/phook2@jhu.edu/data/PWH/public_atac_data/atac-data/preissl_snATAC/test
cd $DIR

# Save the variable passed from the command line which should be a cluster number
IN=$1
echo $IN

# Make a directory for the output. The higher level director was made in submit script
mkdir p56_rep1_fastqs/C${IN}_rep1_reads
OUT=p56_rep1_fastqs/C${IN}_rep1_reads

# Run BBMAP script to extract reads
~/privatemodules/bbmap/bbmap/demuxbyname.sh \
in1=p56.rep1.R1.decomplex.fastq.gz \
out1=$OUT/%.p56.rep1.R1.fastq \
in2=p56.rep1.R2.decomplex.fastq.gz \
out2=$OUT/%.p56.rep1.R2.fastq \
substringmode \
names=cluster_barcodes/C${IN}_p56.rep1_barcodes.txt

exit 0
