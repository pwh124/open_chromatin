*Some data for this directory can be downloaded from Zenodo*:
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `*_roadmap.sh`: Shell scripts containing command line code to calculate pairwise Jaccard statistics for Roadmap Epigenome Atlas DHS open chromatin data and ATAC-seq open chromatin. Scripts download all needed data, process it, and use bedtools to calculate pairwise Jaccard statistics. In the end, a single matrix of pairwise comparisons is returned. This approach is based on [scripts from Aaron Quinlan](http://quinlanlab.org/tutorials/bedtools/bedtools.html#a-jaccard-statistic-for-all-400-pairwise-comparisons) and the script used to create the matrix was created by [Aaron Quinlan](http://quinlanlab.org/)
	- Input: Roadmap BED files, mouse to human ATAC-seq BED files (Zenodo: `hg19_final_peaks.tar.gz`)  
	- Output: `*.matrix` (Zenodo: ?)

- `*.pairwise.Rmd`: RMarkdown files containing R scripts for processing and visualizing pairwise Jaccard statistics. These scripts specifically process and visualize ATAC-seq profiles compared to Roadmap DHS data.
	- Input: `*.matrix` files, `cell-annot.txt` (cell annotation file), and `EIDlegend_mod.txt` (Roadmap annotation file)
	- Output: Heatmaps! See `output/` directory

- `atac-jaccard.Rmd`: RMarkdown file containing R scripts for processing and visualizing pairwise Jaccard statistics. This script specifically processes and visualizes ATAC-seq profiles compared to ATAC-seq profiles.
	- Input: `enh.matrix` file and `cell-annot.txt` (cell annotation file)
	- Output: Heatmaps! See `output/` directory