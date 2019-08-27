*Data for this directory can be downloaded from Zenodo*:

- `batch-summit-liftover.sh`, `batch-all-liftover.sh`, `batch-strict-liftover.sh`: These "batch" shell scripts were used to run the corresponding liftOver scripts for each cell population analyzed. 

- `liftover_summit.sh`, `liftover_all.sh`, `liftover_strict.sh`: Shell scripts for running `bnMapper.py` from the [bnMapper package](https://bitbucket.org/james_taylor/bx-python/wiki/bnMapper) for lifting over .BED files from mm10 to hg19.
	- Input:
	- Output:

- `summit-to-peaks.txt`: Command line code used to convert lifted over, hg19 summit .BED files to peaks. Summits had +/- 250 bp added and then they were sorted. Peaks within each cell population were then merged and peaks intersecting with hg19 ENCODE blacklist regions were removed. These peaks are used in LDSC analysis and fine-mapping.
	- Input:
	- Output: 

- `comparing-peaks.Rmd`: R code used to compare the number of features to be lifted over with the various strategies ("summits","all","strict"). Code includes the production of tables and figures.
	- Input:
	- Output:

