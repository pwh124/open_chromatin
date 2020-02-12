#!/bin/bash

#SBATCH --job-name=ldsc.cts
#SBATCH --time=01:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com
#SBATCH --partition=shared

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

## The name of the processed summary statistic file used in the analysis. This is passed in from the command line from the batch submit script.
SUMSTAT=$1

## Setting directories
DIR=$HOME/data/PWH/public_atac_data/atac-data/ldsc
LDSC_DIR=$HOME/my-python-modules/ldsc
SUM_DIR=$DIR/sumstats/2019_sumstats/final_munge/price_other
CTS_DIR=$DIR/cts
BASE_DIR=$DIR/baseline_v1.1
WEIGHT_DIR=$DIR/1000G_Phase3_weights_hm3_no_MHC
OUT_DIR=$CTS_DIR/2019_out

## Switching versions of python
module load python/2.7-anaconda

## Navigating to ldsc directory in order to activate the python environment needed to run LDSC
cd $LDSC_DIR
source active ldsc

## Navigating to cts_dir
cd $CTS_DIR

## Running LDSC in CTS mode
$LDSC_DIR/ldsc.py \
    --h2-cts $SUM_DIR/$SUMSTAT \
    --ref-ld-chr ../baseline_v1.1/baseline. \
    --out $OUT_DIR/2019_${SUMSTAT%.sumstats}_Hook_ATAC \
    --ref-ld-chr-cts $CTS_DIR/Hook_filter2_ATAC.ldct \
    --w-ld-chr ../1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC.


exit
