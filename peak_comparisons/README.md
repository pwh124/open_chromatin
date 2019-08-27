*Data for this directory can be downloaded from Zenodo*:

- `boca.sh`: Shell script containing command line code to obtain and process ATAC-seq peak files from the [Brain Open Chromatin Atlas (BOCA)](https://genome.cshlp.org/content/early/2018/06/26/gr.232488.117). Peak files were downloaded, minor modifications were made, and neuronal peak files were combined, sorted, and merged.
	- Input: NA
	- Output:

- `roadmap.sh`: Shell script containing command line code to obtain and process DNase peak files from Roadmap Epigenomics Project. Peak files were downloaded, combined, sorted, and merged. Brain-related peaks were also processed in the same way.
	- Input: NA
	- Output:

- `merging_BocaRoadmap.txt`: Command line code used to merge BOCA and Roadmap data.
	- Input:
	- Output:

- `merging_t-cells.txt`: Command line code used to merge T-cell datasets.
	- Input:
	- Output:

- `cd4_overlap.sh`: Text file containing command line code for calculating the overlap between mouse-derived human CD4 ATAC-seq peaks and human CD4 ATAC-seq peaks, naive CD4 Roadmap DNase peaks, memory CD4 DNase peaks, combined naive and memory CD4 DNase peaks, all Roadmap DNase peaks, and all Roadmap DNase peaks plus CD4 ATAC peaks.
	- Input:
	- Output:

- `cd8_overlap.sh`: Text file containing command line code for calculating the overlap between mouse-derived human CD8 ATAC-seq peaks and human CD4 ATAC-seq peaks, naive CD8 Roadmap DNase peaks, memory CD8 DNase peaks, combined naive and memory CD8 DNase peaks, all Roadmap DNase peaks, and all Roadmap DNase peaks plus CD8 ATAC peaks.
	- Input:
	- Output:

- `unique_overlaps.sh`: Text file containing command line code for calculating overlap between all mouse-derived human peaks and open chromatin from BOCA, Roadmap, brain-related Roadmap, and BOCA + Roadmap peaks. Code performs the overlap and creates files tallying each set of overlaps.
	- Input:
	- Output:

- `sample-anno.txt`: Text file containing two comlumns: file names and corresponding cell population names. This was used to properly annotate stuff in R.
	- Input: NA
	- Output: NA

- `public_overlap.Rmd`: R code for combining overlap results and writing them to a readable table.
	- Input:
	- Output: 

- `upsetR.Rmd`: R code used to make upset plots in order to visualize .BED overlaps.
	- Input:
	- Output:

