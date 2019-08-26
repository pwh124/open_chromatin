- *alignment.sh*: Script used to align ATAC-seq data to the mm10 genome. Includes filtering of reads aligned to the mitochondrial genome as well as "unknown" chromosomes and "random" chromosomes. Also removes duplicate reads and improperly paired reads.

- *summit_call.sh*: Script used to call summits for mouse ATAC-seq data. Input are aligned and filtered BAM files and output are peak/summit BED files.

- *filtering-peaks.sh*: Peaks output from MACS2 are filtered based on a normalized peakScore and blacklisted regions are removed. Input are the summit BED files from MACS2 peak calling and the output are filtered summit BED files.

- *comparing-mouse-peaks.txt*: Contains code used in a Linux environment to process files. Filtered summits (created from the script above) were made into peaks (+/- 250 bp on each side) and sorted. Peaks were merged within each cell population with BEDtools and the sizes of merged peaks were calculated. Peaks overlapping with mouse ENCODE blacklisted regions were removed with BEDtools. All peaks from all cell populations were then merged with BEDtools to create a master peak set and a formated .SAF file was created for _featureCounts_. GC content for the peaks was then calculated using BEDtools 'nuc' command.

- *featureCounts.sh*: Script used to create the ATAC-seq peak count matrix. Inputs are .SAF peak file and aligned .BAMs. Outputs are count matrix and count summary matrix.

- *2019_peak_paper.Rmd*: This script analyzes the union peak count matrix created from the peaks called from mm10 ATAC-seq alignment for the 25 mouse cell populations analyzed. The inputs are a count matrix ("2019_peak-counts.txt") and count summary file ("2019_peak-counts.txt.summary") as output by the Subread _featureCount_ program as well as a the GC content of each peak ("2019_gc.bed"). Normalization is performed followed by correlation analysis, principal component analysis, and visualization with t-SNE. Creates "Figure.S1_pca.pdf" and "Figure1A_dendro-tsne_V2.pdf" for the manuscript.




