*Data for this directory can be downloaded from Zenodo*:

- `batch-summit-liftover.sh`, `batch-all-liftover.sh`, `batch-strict-liftover.sh`: These "batch" shell scripts were used to run the corresponding liftOver scripts for each cell population analyzed. 

- `liftover_summit.sh`, `liftover_all.sh`, `liftover_strict.sh`: Shell scripts for running `bnMapper.py` from the [bnMapper package](https://bitbucket.org/james_taylor/bx-python/wiki/bnMapper) for lifting over .BED files from mm10 to hg19.
	- Input: `filter2*summits.bed` and `filter2*peaks.bed` (Zenodo: `filter2_summits_mm10.tar.gz`, `filter2_peaks_mm10.tar.gz`)
	- Output: BED files (Zenodo: `hg19_all-peaks_liftover.tar.gz`, `hg19_strict-peaks_liftover.tar.gz`, `hg19_summits_liftover.tar.gz`)

- `summit-to-peaks.txt`: Command line code used to convert lifted over, hg19 summit .BED files to peaks. Summits had +/- 250 bp added and then they were sorted. Peaks within each cell population were then merged and peaks intersecting with hg19 ENCODE blacklist regions were removed. These peaks are used in LDSC analysis and fine-mapping.
	- Input: `hg19*summits.bed` (Zenodo: `hg19_summits_liftover.tar.gz`)
	- Output: hg19 final peak .BED files (Zenodo: `hg19_final_peaks.tar.gz`)

- `comparing-peaks.Rmd`: R code used to compare the number of features to be lifted over with the various strategies ("summits","all","strict"). Code includes the production of tables and figures. All input files are just the BED files for each individual population concatenated into one large bed.
	- Input: `mouse-peaks.bed`, `all_peaks.bed`, `strict_peaks.bed`, `summit_peaks.bed` (Zenodo: `liftover_combined-bed.tar.gz`)
	- Output: Figures and tables

