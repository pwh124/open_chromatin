####Data for this directory can be downloaded from Zenodo:

- `ldsc_make-annot.sh`: Script for running the "make_annot.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "make_annot.py" script takes .BED files and creates the annotation files needed to run LDSC.
	- Input:
	- Output:

- `ldsc_ld-scoring.sh`: Script for running the "ldsc.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script run with the settings in the script produces the LD score files from annotation files needed for LDSC analysis. Besides our annotations, this script was re-run on Roadmap Control annotations in order to match baseline versions.
	- Input:
	- Output:

- `ldsc_cts.sh`: Script for running the "ldsc.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script with the "--h2-cts" option ran the cell-type specific analyses that are found in the manuscript.
	- Input:
	- Output: 

- `summstats_notes`: Contains notes about how the various GWAS summary statistics were downloaded, processed, and analyzed by LDSC.

- `ldsc_Hook_filter2_ATAC.ldct`: Dictionary file used to run LDSC. First column contains cell population names and second column contains comma separated paths to annotations to test in LDSC.

- `ldsc_combining-results.txt`: File containing command line commands run in order to combine all cell-type specific LDSC results into one file for analysis ("2019_Hook-LDSC_results.txt").
	- Input:
	- Output:

- `ldsc_data_HOOK.Rmd`: R code used to process, analyze, and visualize LDSC results.
	- Input:
	- Output: 