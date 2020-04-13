*Data for this directory can be downloaded from  :*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

###This is a directory containing code for analyzing subsets of mouse-derived human peaks. Note that scripts used for setting up the files used in LDSC were the same used in the full analysis (see `ldsc/` directory). This includes all the batch scripts and the `annot` and `ldscore` scripts.

- `get_hg19_promoters.sh`: This script provides all commands for making a promoter BED file from [GENCODE data](https://www.gencodegenes.org/). It downloads all software and data needed.
	- Input: N/A
	- Output: `hg19_promoter_500.bed` (Zenodo: `gr_subset_peaks.tar.gz`)

- `get_peaks.sh`: This script provides all commands needed to produce peak subsets for each of the 27 cell populations in the manuscript. This includes "promoter","distal","minus", and "unique."
	- Input: hg19 peak .BED files (Zenodo: `gr_hg19_final_peaks.tar.gz`)
	- Output: Promoter, distal, minus, and unique peak  files, `final.bedlist.txt` (Zenodo: `gr_subset_peaks.tar.gz`)

- `*-sz-ldsc-h2.sh`: Scripts for running the `ldsc.py` script from [LDSC software (v1.0.0)](https://github.com/bulik/ldsc). The `ldsc.py` script with the "--h2" option to run the cell annotation analyses for CLOZUK SCZ data for peak subsets.
	- Input: Subset LDSC files in `peakset_ldsc-files/`, re-processed Roadmap Control files for baseline v1.1 in `remade_roadmap_control/`, `*_annotations.txt` in `peakset_ldsc-files`, processed CLOZUK summary statistics `munged_sumstats/` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: LDSC results files for all individual phenotypes in `peakset_SZ-results` for each peakset (Zenodo: `gr_ldsc_files.tar.gz`)

- `combine.sh`: File containing the command line commands which was used to aggregate the different peakset results for each cell annotation test for a trait.
	- Input: LDSC H2 peakset results directories in `peakset_SZ-results` (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: `total_distal_scz_results.txt`,`total_minus_scz_results.txt``total_original_scz_results.txt``total_prom_scz_results.txt` in `peakset_SZ-results/final_results` and in `data/` on GitHub (Zenodo: `gr_ldsc_files.tar.gz`)

- `scz-peaksets_analysis.Rmd`: R code used to process, analyze, and visualize LDSC results for CLOZUK SCZ peak set results
	- Input: `total_clozuk_unique_results.txt`, `total_distal_scz_results.txt`,`total_minus_scz_results.txt``total_original_scz_results.txt``total_prom_scz_results.txt`,`cell-annot.txt` in `peakset_SZ-results/final_results` and in `data/` on GitHub (Zenodo: `gr_ldsc_files.tar.gz`)
	- Output: Various tables and figures
