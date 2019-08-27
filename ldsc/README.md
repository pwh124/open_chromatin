####Data for this directory can be downloaded from Zenodo:

- *proxy-snps.R*: An R script that takes independent lead SNPs as reported in Pardinas, 2018 ("Pardinas_TableS3_new.txt") and finds all the proxy SNPs in 1000 Genomes EUR superpopulation using the R package [proxysnps](https://github.com/slowkow/proxysnps). SNPs are output if they have and r^2 >= 0.1 with the lead SNP and a minor allele frequency >= 0.01. Output is 177 separate locus files.

- *processing-SZ-loci.txt*: A text file containing command line commands processing the loci produced by *proxy-snps.R* into the locus files needed for [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) fine-mapping analysis. It includes combining all the loci files and sorting them based on position and dropping all SNPs that don't have an official RS number. Then, SNPs annotated as being on "Chr23" were converted to "ChrX" and the SNPs were sorted again based on the RS number. CLOZUK schizophrenia summary statistics were then processed to include only SNPs with official RS numbers and are sorted based RS number. Summary SNPs and proxy SNPs were then joined and only SNPs that were able to be joined were retained. The header was then added back on the file and further processing was done with the *paintor-loci.Rmd* script.

- *paintor-loci.Rmd*: R script for modifying and writing out combined proxy SNPs and CLOZUK summary statistics loci. Loci are written out to meet [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) specifications.

- *paintor-ld.sh*:

- *annotate-paintor.sh*:

- *paintor-correlation.Rmd*: 

- *estimate-finemapping-mcmc-null.sh*:

- *estimate-finemapping-mcmc.sh*:

- *finemapping-mcmc-null.sh*:

- *finemapping-mcmc.sh*:

- *processing-results.txt*:

- *paintor-results.Rmd*: 
