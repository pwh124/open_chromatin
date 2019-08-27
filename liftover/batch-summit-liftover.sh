#!/bin/bash

#SBATCH --job-name=batch
#SBATCH --time=00:15:00
#SBATCH --nodes=1
#SBATCH -p shared
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Set up the paths needed to run liftover. "BED_PATH" is the path to the directory containing peak BED files
BED_PATH=$HOME/data/PWH/public_atac_data/atac-data/liftover/mm10_summits_12-17-18/filter_2

## Move into the BED directory
cd $BED_PATH

## Run a for loop on the summit BEDs in order to batch submit them for liftover
for i in `ls -v filter2*bed`
do
sbatch liftover_summit.sh $i
done

exit 0