#!/bin/bash

#SBATCH --job-name=batch-demux
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mail-type=end
#SBATCH --partition=express
#SBATCH --mail-user=pwh124@gmail.com

# Move into the directory where the sequencing was downloaded
DIR=/home-3/phook2@jhu.edu/data/PWH/public_atac_data/atac-data/preissl_snATAC/test
cd $DIR

# process sequencing reads

# Batch submit jobs for Rep1
mkdir p56_rep1_fastqs
for i in {1..9}
do
sbatch demux_rep1.sh $i
done

# rep2
mkdir p56_rep2_fastqs
for i in {1..9}
do
sbatch demux_rep2.sh $i
done
