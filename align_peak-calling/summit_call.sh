#!/bin/bash

#SBATCH --job-name=summit.call
#SBATCH --time=10:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

## Setting up temporary directories so MACS2 does not dump temporary files into my home directory. This quickly fills space if the script fails and prevents log-on.
TMPDIR=$HOME/scratch/tmp

## Sourcing .bash_profile within the script because it contains shortcuts to specific versions of software packages. Also loading other needed modules.
source ~/.bash_profile
module load python/2.7

## Moving into my directory where the alignment files (BAMs) for replicates from each experiment have been merged. Once in the 'merged/' directory, make a directory for the called summits
cd merged/
mkdir -p ../../called_peaks/call-summits_12-12-18

## For loop to call summits for all alignment files. This probably should have been parallelized but it was not. The for loop calls summits for all `sorted*bam* files and outputs summit files with the prefix "shift_ext"
for i in `ls -v sorted*bam`
do
$macs2_path/macs2 callpeak --seed 24 --nomodel --nolambda --call-summits --shift -100 --extsize 200 --keep-dup all --gsize mm  -t $i -n shift_ext_${i%.bam} --outdir ../../called_peaks/call-summits_12-12-18/
done 

exit 0
	
