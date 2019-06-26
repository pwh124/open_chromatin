#!/bin/bash

#SBATCH --job-name=featureCount
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --mail-type=end
#SBATCH --mail-user=pwh124@gmail.com

## Any important cluster specific setting will need to be set above. The settings that pertain to the MARCC cluster at JHU SOM are above. Parameters on commands may need to be changed depending on the server set up.

date

~/privatemodules/subread/subread-1.6.1/bin/featureCounts -T 10 -F SAF -a filter2_merged-peaks.SAF -o 2019_peak-counts.txt ../final_mm10_alignments_5-4-18/merged/sorted*bam

exit 0
