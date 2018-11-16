# Alignment
## Introduction

This is my attempt to start documenting the command line code I am using to process publicly available mouse ATAC-seq data.

I will hopefully be breaking this into scripts to then load on to GitHub for reproducibility.

Almost all of these commands were performed on the MARCC server cluster through JHU.

## Dependencies
### Command line 
[samtools v1.3.1](https://github.com/samtools/samtools/releases/tag/1.3.1), [samtools v0.1.19](https://github.com/samtools/samtools/releases/tag/0.1.19), [bowtie2 v2.2.5](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

### Python 
None

### R  
None

## Rough directory structure
``` 
MAIN_DIR
|-- PROJECT_NAME   
		|-- download  
		|		mm10_alignment.sh  
		|		fastq files from project
		|-- mm10_alignment_results  
		|		.bam files from alignment 
		|		.bai files  
		|		flagstats directory
		|		final_align directory
```
## Code
### Aligning and filtering 

The code used for aligning and filtering the ATAC-seq data is contained in *mm10_alignment.sh*, which is also present in this repository.

Since our cluster had gone through a few conversions, gaining and losing specific packages at any given time, this script has been set up to run off of private modules for bowtie2 and the two different versions of samtools used. The paths for these private modules were placed in my .bash_profile which is then sourced in the script for ease of use.

The directories for the alignment will need to be set up for each different project from which sequencing will be aligned. This will require that this script is copied and modified for the specific sequencing. See the description of the file directory set up above. $MAIN\_DIR should remain invariant. $PROJECT\_NAME (which is the name of the project directory) should change with each publicly available dataset analyzed.

The script takes two commandline variables: the filename prefix for the paired end sequencing and the prefix name you want to append to each created file.

The script would be run as below when running on our cluster:

```shell
sbatch mm10_alignment.sh SRR6305206 SRR6305206
```

In this case, I was super boring and just had the prefixes be identical.

There are numerous files created from this script and at the end you should have something that looks like this in the _mm10\_align_ directory:

```shell
ls -1a *SRR6305206*

pp_rmdup_sorted_SRR6305206_mm10.bam
pp_rmdup_sorted_SRR6305206_mm10.bam.bai
rmdup_sorted_SRR6305206_mm10.bam
sorted_SRR6305206_mm10.bam
sorted_SRR6305206_mm10.bam.bai
mapq_pp_rmdup_sorted_SRR6305206_mm10.bam
mapq_pp_rmdup_sorted_SRR6305206_mm10.bam.bai
```
