#!/bin/bash

#SBATCH --job-name=paintor-ld-new
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

source ~/.bash_profile

## Loading a specific gcc that needed to be used for PAINTOR to work
module load gcc/6.4.0

## Setting up variables to the main directory and to the PAINTOR software
MAINDIR=$HOME/scratch/PWH/paintor/low_ld/new.ld_files
PAINTDIR=$HOME/privatemodules/PAINTOR_V3.0/PAINTOR_Utilities

## Moving into the main directory
cd $MAINDIR

## Saving locus file names as a variable
A=`ls -v --ignore "*.ld" --ignore "annotat*"`

## Running a for loop to create the annotation files needed for all the loci
for i in $A
do
echo $i
python $PAINTDIR/mod-AnnotateLocus.py --input annotation_path.txt --locus $i --out ${i}.annotation --chr chr --pos pos
done

exit 0
