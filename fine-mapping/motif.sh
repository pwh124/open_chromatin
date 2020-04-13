#!/bin/sh
#SBATCH --ntasks-per-node=24
#SBATCH --nodes=1
#SBATCH --time=24:0:0
#SBATCH --job-name=motifs
#SBATCH --error=motif.%J.stdout
#SBATCH --output=motif.%J.stderr
#SBATCH --mail-type=end 
#SBATCH --mail-user=pwh124@gmail.com
#SBATCH --partition=shared
#SBATCH --mem=max

module load R/3.6.1
module load gsl
module load atlas
Rscript --save motifbreakr.R
