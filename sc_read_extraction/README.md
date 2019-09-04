*Data for this directory can be downloaded from Zenodo*:
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

- `bbmap-read-extract.sh`: Bash script used to process sequencing reads from [Preissl, 2018](https://www.nature.com/articles/s41593-018-0079-3). The code uses `demuxbyname.sh` from the [BBMAP software](https://sourceforge.net/projects/bbmap/) to sort reads into cluster categories by barcode.
	- Input: Cell-cluster barcode lists (obtained from Sebastian Preissl, David U. Gorkin, and Rongxin Fang) and sequencing read data (see Table S1)
	- Output: FASTQ files with sequencing reads for each cluster