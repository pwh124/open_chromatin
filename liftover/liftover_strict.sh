#!/bin/bash

#SBATCH --job-name=liftover
#SBATCH --time=02:00:00
#SBATCH -p shared
#SBATCH --nodes=1
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules. The paths for these private modules were placed in my .bash_profile for ease of use.

## Loading bash_profile
source ~/.bash_profile

## Setting paths. These can be changed to whatever they need to be changed to. "BED_PATH" points to where the peak BEDs are stored. "OUT_PATH" is the directory where I want the liftover to go. "CHAIN_PATH" points to the chain used in the liftover. "BED" is the BED file name is that fed in through the batch submit script.
BED_PATH=$HOME/data/PWH/public_atac_data/atac-data/liftover/mm10_summits_12-17-18/paper
OUT_PATH=$HOME/data/PWH/public_atac_data/atac-data/liftover/mm10_summits_12-17-18/paper/liftover/strict
CHAIN_PATH=$HOME/data/PWH/public_atac_data/atac-data/liftover
BED=$1

## Make the output directory if it does not already exist.
mkdir -p $OUT_PATH

## Move into the directory where the peak BEDs are stored.
cd $BED_PATH

## Lift over with bnMapper
python $mapper_path/bnMapper.py -fBED12 -g 20 -t 0.1 $BED $CHAIN_PATH/mm10.hg19.rbest.chain.gz -o $OUT_PATH/strict_hg19_${BED}

exit 0

