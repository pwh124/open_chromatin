#!/bin/sh

# All credit goes to Ming Tang and his list of one-liners: https://github.com/crazyhottommy/bioinformatics-one-liners/blob/master/README.md

# Download fetchChromSizes. "No clobber" (-nc) in case it is already downloaded
wget -nc http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/fetchChromSizes

# Use fetchChromSizes to get hg19 sizes
./fetchChromSizes hg19 > hg19_chrom_sizes.txt

# Download gencode 32 mapped to hg19. Again no clobber
wget -nc ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_32/GRCh37_mapping/gencode.v32lift37.annotation.gtf.gz

# Use the following line if on a SLURM server like I was
#module load bedtools 

# what is the bedtools version if on own machine
bedtools --version

# The actual code to process the gtf and add 500 bp on to each side
gunzip -c  gencode.v32lift37.annotation.gtf.gz | awk '$3=="gene" {print $0}' |  awk -v OFS="\t" '{if ($7=="+") {print $1, $4, $4+1} else {print $1, $5-1, $5}}' | bedtools slop -i - -g hg19_chrom_sizes.txt -b 500 | grep "chr" > hg19_promoter_500.bed

exit 0