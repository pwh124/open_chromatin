*Data for this directory can be downloaded from Zenodo:*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3253181.svg)](https://doi.org/10.5281/zenodo.3253181)

#### This directory contains code for downloading, processing, and analyzing chromatin interaction from:
Song, 2019. "Mapping cis-regulatory chromatin contacts in neural cells links neuropsychiatric disorder risk variants to target genes." Nat. Gen. doi: [https://doi.org/10.1038/s41588-019-0472-1] (https://doi.org/10.1038/s41588-019-0472-1).

#### Note that the HindIII fragment visualization for the pcHiC figures was directly downloaded from the WASHU Epigenome Browser specifically from the legacy browser link provided in Song, 2019 ([link](http://epigenomegateway.wustl.edu/legacy/?genome=hg19&session=8OCs2rkpEA)) - choose the `brain_pchic_nature_genetics_00` session

- `song-download.sh`: This script contains commands to download all significant interactions from Song, 2019 and create a BED file for overlap with fine-mapped SNPs. Also create files that can be visualized on [WASHU Epigenome Browser](https://epigenomegateway.wustl.edu/)
	- Input: Table from Song 2019 (downloaded in script), `song_all.interactions.bed` (created with script), `pip.overlap.snps.bed` (Zenodo: `gr_annotation_data.tar.gz`)
	- Output: `song_excitatory_hic.tsv`, `song_hippocampus_hic.tsv`, `song_motor_hic.tsv`, `song_astro_hic.tsv`, `song_all.interactions.bed`, `snp-hic-interactions.txt`, `WASHU_song-all.interactions.txt`, sorted WASHU cell specific files (Zenodo: `gr_annotation_data.tar.gz`)

- `process-Song.R`: Rscript for processing Song 2019 data into a file that can be overlapped with fine-mapped SNPs.
	- Input: `song_excitatory_hic.tsv`, `song_hippocampus_hic.tsv`, `song_motor_hic.tsv`, `song_astro_hic.tsv` (Zenodo: `gr_annotation_data.tar.gz`)
	- Output: `song_all.interactions.bed` (Zenodo: `annotation_data.tar.gz`)

####As well as [VISTA database data](https://enhancer.lbl.gov/)

- `2019-12-4_vista-processing.txt`: Commands for processing VISTA database into a format that can be used with BEDtools
	- Input: `2019-12-4_VISTA-copypaste.txt`, `pip.overlap.snps.bed` (Zenodo: `gr_annotation_data.tar.gz`)
	- Output: `2019-12-4_VISTA-positive.bed`, `2019-12-4_VISTA-overlaps.txt`, `VISTA-positive-R.bed` (Zenodo: `gr_annotation_data.tar.gz`)