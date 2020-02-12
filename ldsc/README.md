*Data for this directory can be downloaded from Zenodo:*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `ldsc_make-annot.sh`: Script for running the `make_annot.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The `make_annot.py` script takes .BED files and creates the annotation files needed to run LDSC.
	- Input: hg19 peak .BED files (Zenodo: `hg19_final_peaks.tar.gz`)
	- Output: `*{chr}.annot.gz` files (Zenodo: `revise_ldsc_files.tar.gz`)

- `ldsc_ld-scoring.sh`: Script for running the `ldsc.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script run with the settings in the script produces the LD score files from annotation files needed for LDSC analysis. Besides our annotations, this script was re-run on Roadmap Control annotations in order to match baseline versions.
	- Input: `*{chr}.annot.gz` files (Zenodo: `revise_ldsc_files.tar.gz`)
	- Output: `*ldcore.gz`, `*.M`, `*.M_5_50` files (Zenodo:`revise_ldsc_files.tar.gz`)

- `ldsc_h2.sh`: Script for running the `ldsc.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The `ldsc.py` script with the "--h2" option to run the cell annotation analyses that are found in the manuscript.
	- Input: LDSC files (Zenodo: `revise_ldsc_files.tar.gz`), re-processed Roadmap Control files for baseline v1.1 (Zenodo: `ldsc_roadmap_control_remade.tar.gz`), processed summary statistics
	- Output: Result folders (Zenodo: `revise_ldsc_files.tar.gz` in "all_results" directory)

- `summstats_notes`: Contains notes about how the various GWAS summary statistics were downloaded, processed, and analyzed by LDSC.
	- Input: NA
	- Output: NA

- `all_pheno_batch_combine.sh`: File containing command line commands run in order to combine all trait h2 LDSC results into one file for analysis ("all_h2_results.txt").
	- Input: All results folders (Zenodo: `revise_ldsc_files.tar.gz`), results_list.txt
	- Output: `all_h2_results.txt` (Zenodo: `revise_ldsc_files.tar.gz`)

- `combine.sh`: File containing the command line commands aggregates all the results for each cell annotation test for a trait. To be used with `all_pheno_batch_combine.sh` above.
	- Input: LDSC H2 results files (Zenodo: `revise_ldsc_files.tar.gz`)
	- Output: combined result files

- `h2_ldsc_analysis.Rmd`: R code used to process, analyze, and visualize LDSC results for 64 traits
	- Input: `all_h2_results.txt`, `LDSC_phenotypes.txt`, `cell-annot.txt` (Zenodo: `revise_ldsc_files.tar.gz`)
	- Output: Various tables and figures

- `batch*.sh`: Scripts for batch submission of LDSC steps including making annotation, LD scoring, and h2 LDSC analysis. Note `batch-ldsc-h2.sh` uses the `sumstats.txt` in a "while" loop

