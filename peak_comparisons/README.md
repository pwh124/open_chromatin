*Data for this directory can be downloaded from Zenodo*:

- `boca.sh`: Shell script containing command line code to obtain and process ATAC-seq peak files from the [Brain Open Chromatin Atlas (BOCA)](https://genome.cshlp.org/content/early/2018/06/26/gr.232488.117). Peak files were downloaded, minor modifications were made, and neuronal peak files were combined, sorted, and merged.
	- Input: NA
	- Output: `merged_boca_neurons.bed` (Zenodo: `overlap_files.tar.gz`)

- `roadmap.sh`: Shell script containing command line code to obtain and process DNase peak files from Roadmap Epigenomics Project. Peak files were downloaded, combined, sorted, and merged. Brain-related peaks were also processed in the same way.
	- Input: NA
	- Output: `merged_roadmap_imputed_DNase.bed` and `merged_roadmap_brain_DNase.bed` (Zenodo: `overlap_files.tar.gz`)

- `merging_BocaRoadmap.txt`: Command line code used to merge BOCA and Roadmap data.
	- Input: `merged_boca_neurons.bed` and `merged_roadmap_imputed_DNase.bed` (Zenodo: `overlap_files.tar.gz`)
	- Output: `merged_roadmap_boca.bed` (Zenodo: `overlap_files.tar.gz`)

- `merging_t-cells.txt`: Command line code used to merge T-cell datasets.
	- Input: T-cell Roadmap and ATAC-seq data
	- Output: `merged_cd8_atac.roadmap.bed`, ` merged_cd4_atac.roadmap.bed`, `all.roadmap_cd4_atac.bed`, `all.roadmap_cd8_atac.bed` (Zenodo: `overlap_files.tar.gz`)

- `cd4_overlap.sh`: Text file containing command line code for calculating the overlap between mouse-derived human CD4 ATAC-seq peaks and human CD4 ATAC-seq peaks, naive CD4 Roadmap DNase peaks, memory CD4 DNase peaks, combined naive and memory CD4 DNase peaks, all Roadmap DNase peaks, and all Roadmap DNase peaks plus CD4 ATAC peaks.
	- Input:   
	Final CD4 mouse to human ATAC-seq .BED file (Zenodo: `hg19_final_peaks.tar.gz`)  
	Final CD4 human ATAC-seq .BED file (Zenodo: `hg19_final_peaks.tar.gz`)  
	Roadmap data and combined .BEDs (Zenodo: `overlap_files.tar.gz`)  
	- Output: `cd4_peak_overlap.txt` and `cd4_peak_counts.txt` (Zenodo: `overlap_files.tar.gz`)

- `cd8_overlap.sh`: Text file containing command line code for calculating the overlap between mouse-derived human CD8 ATAC-seq peaks and human CD4 ATAC-seq peaks, naive CD8 Roadmap DNase peaks, memory CD8 DNase peaks, combined naive and memory CD8 DNase peaks, all Roadmap DNase peaks, and all Roadmap DNase peaks plus CD8 ATAC peaks.
	- Input:
	- Final CD8 mouse to human ATAC-seq .BED file (Zenodo: `hg19_final_peaks.tar.gz`)  
	Final CD8 human ATAC-seq .BED file (Zenodo: `hg19_final_peaks.tar.gz`)  
	Roadmap data and combined .BEDs (Zenodo: `overlap_files.tar.gz`)  
	- Output: `cd8_peak_overlap.txt` and `cd8_peak_counts.txt` (Zenodo: `overlap_files.tar.gz`)

- `unique_overlaps.sh`: Text file containing command line code for calculating overlap between all mouse-derived human peaks and open chromatin from BOCA, Roadmap, brain-related Roadmap, and BOCA + Roadmap peaks. Code performs the overlap and creates files tallying each set of overlaps.
	- Input:  
	ATAC-seq peak files (`hg19_final_peaks.tar.gz`)  
	BOCA and Roadmap .BED files (Zenodo: `overlap_files.tar.gz`)
	- Output: `hg19_peak_counts.txt`, `boca_peak_overlap.txt`, `brain_roadmap_peak_overlap.txt`, `combined_peak_overlap.txt`, `roadmap_peak_overlap.txt` (Zenodo: `overlap_files.tar.gz`)

- `sample-anno.txt`: Text file containing two comlumns: file names and corresponding cell population names. This was used to properly annotate stuff in R.
	- Input: NA
	- Output: NA

- `public_overlap.Rmd`: R code for combining overlap results and writing them to a readable table.
	- Input: `hg19_peak_counts.txt`, `boca_peak_overlap.txt`, `brain_roadmap_peak_overlap.txt`, `combined_peak_overlap.txt`, `roadmap_peak_overlap.txt`, `sample-anno.txt` (Zenodo: `overlap_files.tar.gz`)
	- Output: `unique_overlap_comparisons.txt` (Zenodo: `overlap_files.tar.gz`)

- `upsetR.Rmd`: R code used to make upset plots in order to visualize .BED overlaps.
	- Input: Numbers from `unique_overlap_comparisons.txt` (Zenodo: `overlap_files.tar.gz`)
	- Output: `cd8.upset.pdf` and `neuron.upset.pdf` which were then modified to make `mod-cd8.upset.pdf` and `mod-neuron.upset.pdf`

