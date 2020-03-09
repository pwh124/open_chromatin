*Data for this directory can be downloaded from Zenodo:*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `alignment.sh`: Script used to align ATAC-seq data to the mm10 genome. Includes filtering of reads aligned to the mitochondrial genome as well as "unknown" chromosomes and "random" chromosomes. Also removes duplicate reads and improperly paired reads.
	- Input: sequencing reads (see Table S1)
	- Output: BAMs

- `summit_call.sh`: Script used to call summits for mouse ATAC-seq data. Input are aligned and filtered BAM files and output are peak/summit BED files.
	- Input: BAMs
	- Output: MACS2 files (Zenodo: `summits-macs2_mm10.tar.gz`)

- `filtering-peaks.sh`: Summit output from MACS2 are filtered based on a normalized peakScore and blacklisted regions are removed. Input are the summit BED files from MACS2 peak calling and the output are filtered summit BED files.
	- Input: *summits.bed files (Zenodo: `summits-macs2_mm10.tar.gz`)
	- Output: filter2*summits.bed (Zenodo: `filter2_summits_mm10.tar.gz`)

- `creating-mouse-peaks.txt`: Contains code used in a Linux environment to process files. Filtered summits (created from the script above) were made into peaks (+/- 250 bp on each side) and sorted. Peaks were merged within each cell population with BEDtools and the sizes of merged peaks were calculated. Peaks overlapping with mouse ENCODE blacklisted regions were removed with BEDtools. All peaks from all cell populations were then merged with BEDtools to create a master peak set and a formated .SAF file was created for _featureCounts_. GC content for the peaks was then calculated using BEDtools 'nuc' command.
	- Input: filter2*summits.bed (Zenodo: `filter2_summits_mm10.tar.gz`)
	- Output: filter2*peaks.bed, `filter2_merged-peaks-mm10.SAF`, `2019_gc.bed` (Zenodo: `filter2_peaks_mm10.tar.gz`, `mm10-peaks-counts.tar.gz`)

- `featureCounts.sh`: Script used to create the ATAC-seq peak count matrix. It makes use of the _featureCounts_ program from the Subread software package.  Inputs are .SAF peak file and aligned .BAMs. Outputs are count matrix and count summary matrix.
	- Input: BAM files, `filter2_merged-peaks-mm10.SAF`
	- Output: `2019_peak-counts.txt` (Zenodo: `mm10-peaks-counts.tar.gz`)

- `2019_peak_paper.Rmd`: This script analyzes the union peak count matrix created from the peaks called from mm10 ATAC-seq alignment for the 25 mouse cell populations analyzed. The inputs are a count matrix (`2019_peak-counts.txt`) and count summary file (`2019_peak-counts.txt.summary`) as output by the Subread _featureCount_ program as well as a the GC content of each peak (`2019_gc.bed`). Normalization is performed followed by correlation analysis, principal component analysis, and visualization with t-SNE. Creates `Figure.S1_pca.pdf` and `Figure1A_dendro-tsne.pdf` for the manuscript.
	- Input: `2019_peak-counts.txt`, `2019_peak-counts.txt.summary`, `peak-annot.txt`, `2019_gc.bed` (Zenodo: `mm10-peaks-counts.tar.gz`)
	- Output: `Figure1A_dendro-tsne.pdf`, `Figure.S1_pca.pdf`

	**Note**: t-SNE plot output may look slightly different when run on a different machine (even with the same seed). Regardless, the main observations from the plot remain the same (this has been tested).
	
### To Do: Nothing




