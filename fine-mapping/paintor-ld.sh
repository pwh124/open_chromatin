#!/bin/bash

#SBATCH --job-name=paintor-ld
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

source ~/.bash_profile

## Loading a specific gcc that needed to be used for PAINTOR to work
module load gcc/6.4.0

## Saving the chromosome from the command line input
chr=$1

## Setting up variables to the main directory and to the PAINTOR software
MAINDIR=$HOME/scratch/PWH/paintor/low_ld/new.paintor.loci
PAINTDIR=$HOME/privatemodules/PAINTOR_V3.0

## Moving into the main directory
cd $MAINDIR

## Creating a variable that pulls out all the loci on a specific chromosome
A=`ls ${chr}.*`

## Running a for loop that creates LD files for PAINTOR
for i in $A
do
echo $i
python $PAINTDIR/PAINTOR_Utilities/mod-CalcLD_1KG_VCF.py \
--locus $i \
--reference ../beagle_1000G/${chr}.1kg.phase3.v5a.vcf.gz  \
--map ../beagle_1000G/integrated_call_samples_v3.20130502.ALL.panel \
--effect_allele A1 \
--alt_allele A2 \
--population EUR \
--Zhead Zscore \
--out ../new.ld_files/out_${i%.hdl} \
--position pos
done

exit 0
