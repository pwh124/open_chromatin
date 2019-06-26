#!/bin/bash

#SBATCH --job-name=demultiplex
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## The name of the P56 cluster from Priessl 2018 (C1, C2,...) is passed in from the command line. This script extracts reads from the 'rep2' sequencing but it was modified to extract from 'rep1' as well.

## Setting up directory variables
DIR='/home-3/phook2@jhu.edu/data/PWH/public_atac_data/atac-data'
PROJECT='preissl_snATAC/download'

## Making working directory
cd $DIR/$PROJECT
DIR2=${1}_rep2_reads
mkdir $DIR2

## Running bbmap 'demuxbyname.sh' in order to pull out all the reads that belong in a cluster. Cluster barcodes were provided by Sebastian Preissl, David U. Gorkin and Rongxin Fang and are deposited on Zenodo.
~/privatemodules/bbmap/bbmap/demuxbyname.sh in1=p56.rep2.R1.decomplex.fastq \
out1=$DIR2/%.rep2.R1.fastq \
in2=p56.rep2.R2.decomplex.fastq \
out2=$DIR2/%.rep2.R2.fastq \
substringmode \
names=../barcode-clusters/cluster_barcodes/p56_rep2_${1}_barcodes.txt

exit 0
