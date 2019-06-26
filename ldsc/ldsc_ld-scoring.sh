#!/bin/bash

#SBATCH --job-name=ld_scoring
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

source ~/.bash_profile

## Setting directories for running the LD scoring for LDSC annotations. In this example of the script, the LD scores for the Roadmap control ATAC-seq data were being recalculated. The exact same script was run for all ATAC-seq annotations.
DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/
ANNOT_DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc/roadmap_control

## Setting prefix for all the files
prefix="Roadmap.control"

## Loading LDSC and activating the python environment
module load python/2.7-anaconda
cd ~/my-python-modules/ldsc
source activate ldsc

## Moving into the annotation directory
cd $ANNOT_DIR

## Running LDSC ldsc.py for all 22 chromosomes with a for loop.
for chr in {1..22}
do
	python ~/my-python-modules/ldsc/ldsc.py \
		--l2 \
		--bfile ../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr} \
		--ld-wind-cm 1 \
		--thin-annot \
		--annot ${prefix}.${chr}.annot.gz \
		--out ${prefix}.${chr} \
		--print-snps ../hapmap3_snps/hm.${chr}.snp
done

exit 0



