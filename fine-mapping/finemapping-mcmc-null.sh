#!/bin/bash

#SBATCH --job-name=null.mcmc
#SBATCH --time=72:00:00
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
PAINTDIR=$HOME/privatemodules/PAINTOR_V3.0

## Running PAINTOR in order to fine-map variants without ATAC-seq annotation
$PAINTDIR/PAINTOR -input input.files \
-in $MAINDIR \
-out $MAINDIR/results \
-Zhead Zscore \
-LDname ld \
-Gname null.Enrich.mcmc \
-Lname null.BF.mcmc \
-mcmc \
-burn_in 100000 \
-max_samples 1000000 \
-num_chains 5 \
-RESname null.mcmc.results \
-ANname annotation \
-set_seed 3 \
-gamma_initial 3.6 \
-MI 3

exit 0
