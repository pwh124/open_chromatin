#!/bin/sh
#SBATCH --job-name=batch-ldsc-h2
#SBATCH --time=01:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com
#SBATCH --partition=debug

basedir=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision
cd basedir

while read -r line;
do
sbatch ldsc_h2.sh $line;
done < sumstats.txt


exit 0
