*Data for this directory can be downloaded from Zenodo:*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `ldsc_make-annot.sh`: Script for running the "make_annot.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "make_annot.py" script takes .BED files and creates the annotation files needed to run LDSC.
	- Input: hg19 peak .BED files (Zenodo: )
	- Output: `*{chr}.annot.gz` files (Zenodo: ``ldsc_files.tar.gz``)

- `ldsc_ld-scoring.sh`: Script for running the "ldsc.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script run with the settings in the script produces the LD score files from annotation files needed for LDSC analysis. Besides our annotations, this script was re-run on Roadmap Control annotations in order to match baseline versions.
	- Input: `*{chr}.annot.gz` files (Zenodo: ``ldsc_files.tar.gz``)
	- Output: `*ldcore.gz`, `*.M`, `*.M_5_50` files (Zenodo: ``ldsc_files.tar.gz``)

- `ldsc_cts.sh`: Script for running the "ldsc.py" script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script with the "--h2-cts" option ran the cell-type specific analyses that are found in the manuscript.
	- Input: `Hook_filter2_ATAC.ldct`, LDSC files (Zenodo: `ldsc_files.tar.gz`), re-processed Roadmap Control files for baseline v1.1 (Zenodo: `ldsc_roadmap_control_remade.tar.gz`
	- Output: `*.cell_type_results.txt` (Zenodo: `ldsc_files.tar.gz`)

- `summstats_notes`: Contains notes about how the various GWAS summary statistics were downloaded, processed, and analyzed by LDSC.
	- Input: NA
	- Output: NA

- `ldsc_Hook_filter2_ATAC.ldct`: Dictionary file used to run LDSC. First column contains cell population names and second column contains comma separated paths to annotations to test in LDSC.
	- Input: NA
	- Output: NA

- `ldsc_combining-results.txt`: File containing command line commands run in order to combine all cell-type specific LDSC results into one file for analysis ("2019_Hook-LDSC_results.txt").
	- Input: `*.cell_type_results.txt` (Zenodo: `ldsc_files.tar.gz`)
	- Output: `2019_Hook-LDSC_results.txt` (Zenodo: `ldsc_files.tar.gz`)

- `ldsc_data_HOOK.Rmd`: R code used to process, analyze, and visualize LDSC results.
	- Input: `2019_Hook-LDSC_results.txt` and `2019_LDSC_phenotypes.txt` (Zenodo: `ldsc_files.tar.gz`)
	- Output: Various tables and figures