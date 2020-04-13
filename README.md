# open_chromatin

This is the repositiory the for paper entitled:
   
###Leveraging mouse chromatin data for heritability enrichment informs common disease architecture and reveals cortical layer contributions to schizophrenia  

Published manuscript:  To be updated soon  
bioRxiv version: [https://doi.org/10.1101/427484](https://doi.org/10.1101/427484)  
Note: There were substantial changes betweent the preprint and published versions.

Most data processed and used by code in this repo is deposited on Zenodo (Concept DOI):  
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253180.svg)](https://doi.org/10.5281/zenodo.3253180)

Please contact me at phook2 [at] jhmi.edu with any questions or comments.


## April 2020

### Supplemental\_Code\_1 for Hook and McCallion, 2020

- **align_peak-calling**: Contains code pertaining to the alignment of ATAC-seq reads, the calling of open chromatin peaks, and the visualization of this data   - **annotations**: Contains code pertaining to processing of promoter-capture Hi-C data and VISTA Enhancer Browser data  - **fine-mapping**: Contains code pertaining to the set-up, execution, and analysis of fine-mapping of schizophrenia SNPs  - **jaccard_comparisons** Contains code pertaining to the download of Roadmap Epigenomics Project open chromatin data and the base pair level pairwise comparisons performed in the manuscript  - **ldsc**: Contains code pertaining to the set-up, execution, and analysis of heritability enrichment analyses performed with LDSC using mouse-derived human open chromatin profiles  - **ldsc_peaksets**: Contains code pertaining to the set-up, execution, and analysis of heritability enrichment analyses performed with LDSC using subsets of mouse-derived human open chromatin profiles. Some code used for this analysis will be in the "ldsc/" directory  - **liftover**: Contains code pertaining to the conversion of mouse open chromatin profiles to human open chromtain profiles    - **peak_comparisons**: Contains code pertaining to the peak level comparisons of mouse-derived human open chromatin profiles and human open chromatin profiles  - **sc\_read\_extraction**: Contains code and some key files pertaining to the extraction of single-nuclei ATAC-seq reads belonging to clusters of cell populations from "Single-nucleus analysis of accessible chromatin in developing mouse forebrain reveals cell-type-specific transcriptional regulation" (Preissl, 2018)  

####Note: More details for all the scripts within each folder is provided by the `README.md` in each folder  

####Data can be found here on Zenodo here with the prefix "gr_":  [https://doi.org/10.5281/zenodo.3253180](https://doi.org/10.5281/zenodo.3253180)  
  
-----  
-----  
-----

## Previous updates

### 09-04-2019

Major code update! All code added and updated for the second version of the manuscript posted on bioRxiv above. Each directory contains a README.md document in which I have provided detailed descriptions of all code in the directory.

### 06-26-2019

Added a bunch of code including code using in ATAC-seq alignment and peak calling (align_peak-calling), linkage disequilibrium score regression (ldsc), liftOver (liftover), comparison of peaks (peak_comparisons), read extraction from single-cell data (sc_read_extraction), and fine-mapping of SZ loci using PAINTOR (fine-mapping).

### 06-14-2019

As will surely be obvious, this repo was not continuously updated!

A new manuscript with modifed and additional analyses is nearing completion so the smattering of code associated with v1 of the manuscript is now archived in the "v1_archive" directory.

New scripts will be uploaded for the new manuscript shortly! Stay tuned! 

### 10-15-2018
- Added output from "ldsc_R_code.Rmd" including figures 1, 2, S2, and S3

### 10-10-2018
- Uploaded code for running LDSC on ATAC-seq peaks ("running-ldsc.md")
- Uploaded BED file ("hg19_combined_peaks.tar.gz") containing all peaks used in LDSC analysis. This includes chromosome, start, end, and cell population where the peak came from.
- Uploaded BED file ("mm10_merged_peaks.tar.gz") containing the mm10 merged peak set. This includes chromosome, start, end, and number of cell populations from which the merged became came from.
- Uploaded RMarkdown used to visualize and further analyze LDSC results ("ldsc_R_code.Rmd"). Files produced by this script are also slowly being added to the repo.

### 10-01-2018

- Results and logs from LDSC cell type specific analyses ("ldsc_cts_results" and "ldsc_cts_logs", respectively) have been uploaded  
- Logs from LDSC summary statistic munging ("ldsc_sumstats_logs") have been uploaded

