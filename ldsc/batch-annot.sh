#!/bin/bash

#SBATCH --job-name=shared-batch_annot
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

source ~/.bash_profile

#Setting dirs
DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision
BED_DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision/bed

#grabbing names of bed files to make annot files from
cd $BED_DIR
BED=`ls -v *.bed`

#switching back to make-annot directory
cd $DIR

#running the for loop to make all the annot files
for i in $BED
do
sbatch ldsc_make-annot.sh $i
done

exit
