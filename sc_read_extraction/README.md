*Data for this directory can be downloaded from Zenodo*:
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253180.svg)](https://doi.org/10.5281/zenodo.3253180)

#### These scripts were used to process single-nuclei ATAC-seq data from [Preissl, 2018](https://www.nature.com/articles/s41593-018-0079-3). The multiplexed FASTQ files are publically available and were downloaded using the commands:  
> `wget http://renlab.sdsc.edu/r3fang/projects/Preissl_Nat_Neuro/data_raw/p56.rep1.R1.decomplex.fastq.gz`  
> `wget http://renlab.sdsc.edu/r3fang/projects/Preissl_Nat_Neuro/data_raw/p56.rep1.R2.decomplex.fastq.gz`  

#### The `/data` directory on GitHub also contains a file called "preissl-populations.txt" which contains the key to go from cluster number to identified cell population. This was provided by Sebastian Preissl, David U. Gorkin, and Rongxin Fang. This file is also found on Zenodo (`gr_sn_read_extraction.tar.gz`)

- `snATAC-barcode-processing.txt`: Text file containing command line scripts used to create lists of barcodes for each P56 cluster found in [Preissl, 2018](https://www.nature.com/articles/s41593-018-0079-3)
	- Input: `p56_cluster.txt` (Cell-cluster barcode list obtained from Sebastian Preissl, David U. Gorkin, and Rongxin Fang) (Zenodo: `gr_sn_read_extraction.tar.gz`, `data/` on GitHub)
	- Output: Replicate and cluster specific barcode lists (Zenodo: `gr_sn_read_extraction.tar.gz`, `data/` on GitHub)

- `batch-demux.sh`: Shell script used to batch submit demultiplexing jobs to a computing cluster. Includes creation of replicate directories

- `demux_rep1.sh` and `demux_rep2.sh`: Shell scripts that take the input of `batch-demux.sh` above and uses `demuxbyname.sh` from the [BBMAP software](https://sourceforge.net/projects/bbmap/) to sort reads into cluster categories by barcode. Note that after this step, all FASTQ files for each cluster-replicate were concatenated together and aligned to the mm10 genome.
	- Input: Replicate and cluster specific barcode lists (Zenodo: `gr_sn_read_extraction.tar.gz`, `data/` on GitHub)
	- Output: FASTQ files with sequencing reads for each cluster