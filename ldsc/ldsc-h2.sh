#!/bin/sh
#SBATCH --job-name=sumstat-h2
#SBATCH --time=06:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com
#SBATCH --partition=shared

sumstat=$1

basedir=$HOME/data/PWH/public_atac_data/atac-data/ldsc/cts/h2_revision
outdir=${sumstat%.sumstats.gz}
echo $outdir
LDSCdir=$HOME/my-python-modules/ldsc

#Switching versions of python
module load python/2.7-anaconda

#Navigating to ldsc directory
cd $LDSCdir
source activate ldsc

#Navigating to basedir
cd $basedir

#mkdir
mkdir -p results/$outdir

while read -r line;
do
$LDSCdir/ldsc.py \
--h2 sumstats/$sumstat \
--ref-ld-chr filter2_summit/${line}.,roadmap_control/Roadmap.control.,baseline_v1.1/baseline. \
--out results/$outdir/${line} \
--overlap-annot  \
--frqfile-chr 1000G_Phase3_frq/1000G.EUR.QC. \
--w-ld-chr 1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--print-coefficients;
done < annotations.txt


exit 0
