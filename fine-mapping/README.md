####Data for this directory can be downloaded from Zenodo:

- `proxy-snps.R`: An R script that takes independent lead SNPs as reported in Pardinas, 2018 ("Pardinas_TableS3_new.txt") and finds all the proxy SNPs in 1000 Genomes EUR superpopulation using the R package [proxysnps](https://github.com/slowkow/proxysnps). SNPs are output if they have and r^2 >= 0.1 with the lead SNP and a minor allele frequency >= 0.01. Output is 177 separate locus files.
	- Input: `Pardinas_TableS3_new.txt`
	- Output: `*proxy-snps.new.txt` (Zenodo: `paintor_files.tar.gz` )

- `processing-SZ-loci.txt`: A text file containing command line commands for processing the loci produced by *proxy-snps.R* into the locus files needed for [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) fine-mapping analysis. It includes combining all the loci files and sorting them based on position and dropping all SNPs that don't have an official RS number. Then, SNPs annotated as being on "Chr23" were converted to "ChrX" and the SNPs were sorted again based on the RS number. CLOZUK schizophrenia summary statistics were then processed to include only SNPs with official RS numbers and are sorted based RS number. Summary SNPs and proxy SNPs were then joined and only SNPs that were able to be joined were retained. The header was then added back on the file and further processing was done with the *paintor-loci.Rmd* script.
	- Input: `*proxy-snps.new.txt`, CLOZUK SZ summary statistics (Zenodo: `paintor_files.tar.gz`)
	- Output: `final.keep.id.clozuk_ld_join.txt` (Zenodo: `paintor_files.tar.gz`)

- *paintor-loci.Rmd*: R script for modifying and writing out combined proxy SNPs and CLOZUK summary statistics loci. Loci are written out to meet [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) specifications.
	- Input: `final.keep.id.clozuk_ld_join.txt` (Zenodo: `paintor_files.tar.gz`)
	- Output: `*.hdl` loci files (Zenodo: `paintor_files.tar.gz`)

- *paintor-ld.sh*: Contains the script used to run the Python script included with [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) to calculate LD matricies for each tested schizophrenia locus.  
	- Input: `*.hdl` loci files (Zenodo: `paintor_files.tar.gz`)
	- Output: `*.processed` loci files, `*.processed.ld` files (Zenodo: `paintor_files.tar.gz`)

- *annotate-paintor.sh*: Contains the script used to run the Python script included with [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) to create binary matrices for the ATAC-seq peaks used as annotations during fine-mapping.  
	- Input: `*.processed` loci files, `annotation_path.txt`, hg19 peak .BED files (`paintor_files.tar.gz`)
	- Output: `*.processed.annotation` files

- *paintor-correlation.Rmd*: R scripts used to check the correlation between annotations used in [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) analysis.  
	- Input: `final.all.overlap.txt` (Zenodo: `paintor_results.tar.gz`)
	- Output: NA

- *estimate-finemapping-mcmc-null.sh*: Script used to estimate "gamma_initial" for the null model for input to the longer fine-mapping script. This script allowed for us to run an [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) MCMC instance with a long "burn_in" and "max_samples" with only 1 iteration. The script runs the main "PAINTOR" command included in the [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) package.  
	- Input: PAINTOR locus files (Zenodo: `paintor_files.tar.gz`)
	- Output: `estimate_null` (Zenodo: `paintor_results.tar.gz`)

- *estimate-finemapping-mcmc.sh*: Script used to estimate "gamma_initial" for the annotation model for input to the longer fine-mapping script. This script allowed for us to run an [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) MCMC instance with a long "burn_in" and "max_samples" with only 1 iteration. The script runs the main "PAINTOR" command included in the [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) package.  
	- Input: PAINTOR locus files (Zenodo: `paintor_files.tar.gz`)
	- Output: `estimate_anno` (Zenodo: `paintor_results.tar.gz`)

- *finemapping-mcmc-null.sh*: Script used to run the null model for the long MCMC fine-mapping script. The script runs the main "PAINTOR" command included in the [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) package. It produces the null model results in the paper. 
	- Input: PAINTOR locus files (Zenodo: `paintor_files.tar.gz`)
	- Output: `null_mcmc` (Zenodo: `paintor_results.tar.gz`)

- *finemapping-mcmc.sh*: Script used to run the annotation model for the long MCMC fine-mapping script. The script runs the main "PAINTOR" command included in the [PAINTOR](https://github.com/gkichaev/PAINTOR_V3.0) package. It produces the annotation model results in the paper. 
	- Input: PAINTOR locus files (Zenodo: `paintor_files.tar.gz`)
	- Output: `anno_mcmc` (Zenodo: `paintor_results.tar.gz`)

- *processing-results.txt*: A text file containing command line commands for processing PAINTOR fine-mapping results produced by *finemapping-mcmc.sh* and *finemapping-mcmc-null.sh* into something that can be analyzed in R. First, the binary ".annotation" files for each locus were combined into one file ("final.all.overlap.txt"). Next, the loci results for the null results were combined into one file ("final.all.null.results.txt"). The same was done with the annotation results ("final.all.anno.results.txt").
	- Input: `null_mcmc` and `anno_mcmc` (Zenodo: `paintor_results.tar.gz`)
	- Output: `variant_overlap` and `results` (Zenodo: `paintor_results.tar.gz`)

- *paintor-results.Rmd*: R scripts to process the fine-mapping results and make tables and figures.
	- Input: `final.all.anno.results.txt`, `final.all.null.results.txt`, `final.all.overlap.txt`
	- Ouput: Various figures and tables
