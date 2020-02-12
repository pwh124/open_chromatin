#!/bin/bash

#SBATCH --job-name=shared-batch_ldscore
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

source ~/.bash_profile

#Setting dirs
DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision
ANNOT_DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision/bed

#grabbing prefixes of annot files to score
cd $ANNOT_DIR
A=`ls -v *.bed | awk -F '.' '{print $1}' - | uniq`

#switching back to ldscore directory
cd $DIR

#running the for loop to make all the annot files
for i in $A
do
sbatch ldsc_ld-scoring.sh $i
done

exit
