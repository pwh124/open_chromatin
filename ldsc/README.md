*Data for this directory can be downloaded from Zenodo:*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `ldsc_make-annot.sh`: Script for running the `make_annot.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The `make_annot.py` script takes .BED files and creates the annotation files needed to run LDSC.
	- Input: hg19 peak .BED files (Zenodo: `gr_hg19_final_peaks.tar.gz`)
	- Output: `*{chr}.annot.gz` files in `summits_ldsc-files/` (Zenodo: `gr_ldsc_files.tar.gz`)

- `ldsc_ld-scoring.sh`: Script for running the `ldsc.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The "ldsc.py" script run with the settings in the script produces the LD score files from annotation files needed for LDSC analysis. Besides our annotations, this script was re-run on Roadmap Control annotations in order to match baseline versions.
	- Input: `*{chr}.annot.gz` files in `summits_ldsc-files/` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: `*ldcore.gz`, `*.M`, `*.M_5_50` files in `summits_ldsc-files/`(Zenodo:`gr_ldsc_files.tar.gz`)

- `ldsc_h2.sh`: Script for running the `ldsc.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The `ldsc.py` script with the "--h2" option to run the cell annotation analyses that are found in the manuscript.
	- Input: LDSC files in `summits_ldsc-files/`, re-processed Roadmap Control files for baseline v1.1 in `remade_roadmap_control/`, processed summary statistics in `munged_sumstats` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: Summit result directories in `summits_all-results/` (Zenodo: `gr_ldsc_files.tar.gz`)

- `summstats_notes`: Contains notes about how the various GWAS summary statistics were downloaded, processed, and analyzed by LDSC.
	- Input: NA
	- Output: NA

- `all_pheno_batch_combine.sh`: File containing command line commands run in order to combine all trait h2 LDSC results into one file for analysis (`all_h2_results.txt`).
	- Input: `total*.txt` result files (Zenodo: `gr_ldsc_files.tar.gz`), results_list.txt
	- Output: `all_h2_results.txt` in `summits_all-results/` (Zenodo: `gr_ldsc_files.tar.gz`)

- `combine.sh`: File containing the command line commands to aggregate all the results for each cell annotation test for a trait. To be used with `all_pheno_batch_combine.sh` above.
	- Input:  Summit result directories in `summits_all-results/` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: `total*.txt` result files in results directories in `summits_all-results\` (Zenodo: `gr_ldsc_files.tar.gz`)

- `h2_ldsc_analysis.Rmd`: R code used to process, analyze, and visualize LDSC results for 64 traits
	- Input: `all_h2_results.txt` in in `summits_all-results/`, `LDSC_phenotypes.txt`, `cell-annot.txt` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: Various tables and figures

- `batch*.sh`: Scripts for batch submission of LDSC steps including making annotation, LD scoring, and h2 LDSC analysis. Note `batch-ldsc-h2.sh` uses the `sumstats.txt` in a "while" loop