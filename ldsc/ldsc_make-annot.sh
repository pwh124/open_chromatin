#!/bin/bash

#SBATCH --job-name=annot
#SBATCH --time=01:00:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

## Sourcing my .bash_profile
source ~/.bash_profile

## Setting variables including the BED file that will be passed in by the batch submit script and the directory containing the annotations.
BED=$1
DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/filter2_summit

## Loading the LDSC environment
module load python/2.7-anaconda
cd ~/my-python-modules/ldsc
source activate ldsc

## Moving into the directory where all annotations are kept
cd $DIR

## Running a for loop in order to create LDSC annot files for all chromosomes
for chr in {1..22}
do
	python ~/my-python-modules/ldsc/make_annot.py \
		--bed-file $BED \
		--bimfile ../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr}.bim \
		--annot-file ${BED%.bed}.${chr}.annot.gz
done

exit 0
