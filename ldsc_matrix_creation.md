#Making annotation matrix from LDSC data

Ultimately with this ATAC-seq data, we would like to try to pinpoint individual variants (common SNPs) in individual loci associated with a trait.

In the past, we have done this by creating an "annotation matrix"... essentially a binary matrix that tells us whether (1) or not (0) a SNP is overlapped by an open chromatin region in a specific cell type.

I begin by unzipping all the .annot files

```shell
#atac .annot.gz
for i in `ls -v *annot.gz`; do zcat $i > ../matrix_files/${i%.gz}; done 

#baseline .annot.gz
for i in `ls -v ../../1000G_EUR_Phase3_baseline/*annot.gz`; do zcat $i > ../matrix_files/${i%.gz}; done 
```
Now I need to concatenate all the columns for all the annotations for each chromosome and name those columns so I know which are which

```shell
for i in {1..22}; do { for f in *_hg19.${i}.annot; do awk '{ for(i=1;i<=NF;i++) printf("%s\t",FILENAME); exit }' "$f"; done; echo ""; paste -d"\t" *_hg19.${i}.annot; } | column -t > hg19_${i}_combined.txt; done
```
I then remove "ANNOT" from the dataframe, which was added when combining everything together.

```shell
for i in {1..22}; do sed '/ANNOT/d' hg19_${i}_combined.txt > mod_hg19_${i}_combined.txt; done
```

I then create a "sum" column that will add up all the annotations for each SNP (only for my ATAC-seq annotations).

```shell
for i in {1..22}; do awk 'BEGIN {print "sum"}; NR>1 {sum=0; for(i=1; i<=NF; i++) sum += $i; print sum }' mod_hg19_${i}_combined.txt | paste mod_hg19_${i}_combined.txt - > sum_mod_hg19_${i}_combined.txt; done
```

I can then check that the same number of SNPs are in the baseline and ATAC data sets

```shell
cat baseline.* | wc -l  
9997253

cat sum_mod_hg19_* | wc -l
9997253
```

Now that I made sure they had the same # of SNPs, I can concatenate all the chromosomes together and then paste the baseline and ATAC datasets together

```shell
cat baseline.{1..22}.annot > cat_baseline.all.annot

cat sum_mod_hg19_{1..22}_combined.txt > cat_sum_mod_hg19_all_combined.txt

paste cat_baseline.all.annot cat_sum_mod_hg19_all_combined.txt > baseline.atac_annot.txt
```

I can then check to see if everything was concatenated/pasted correctly by counting the number of headers (it should have 22 header rows, one from each chromosome).

```shell
awk '$1=="CHR" {print $0}' baseline.atac_annot.txt | wc -l
22
```

I now want to remove all header lines except for the first one

```shell
sed -e '2,${ /CHR/d }' baseline.atac_annot.txt > final_baseline.atac_annot.txt
```

Checking numbers

```shell
wc -l final_baseline.atac_annot.txt 
9997232 final_baseline.atac_annot.txt

# This value -21 should equal the value above (It does!)
wc -l baseline.{1..22}.annot
   779355 baseline.1.annot
   839591 baseline.2.annot
   706351 baseline.3.annot
   729646 baseline.4.annot
   633016 baseline.5.annot
   664017 baseline.6.annot
   589570 baseline.7.annot
   549972 baseline.8.annot
   438107 baseline.9.annot
   510502 baseline.10.annot
   493923 baseline.11.annot
   480111 baseline.12.annot
   366201 baseline.13.annot
   324699 baseline.14.annot
   287002 baseline.15.annot
   316982 baseline.16.annot
   269223 baseline.17.annot
   285157 baseline.18.annot
   232364 baseline.19.annot
   221627 baseline.20.annot
   138713 baseline.21.annot
   141124 baseline.22.annot
  9997253 total
```

In order to actually look at informative SNPs that overlap our regions, I want to just look at all SNPs that were fed in to the regression. The way I could do that would be to try to replicate the “Prop._SNP” value for the cell populations when the regular LDSC is run (see “sz_heritability” directory)

Checking the final proportion of SNPs overlapping open chromatin regions for 4 populations to see if the number calculated as part of heritability estimates by LDSC matches.   

In order to do this I tried many different methods, but I soon realized that only SNPs with a FRQ > 0.05 are included in the analysis. So I did the following:

The following script concatenates all the frequency files together in order, removes all headers except for the first one, and prints snps with MAF > 0.05.

```shell
cat ../../1000G_Phase3_frq/*.{1..22}.frq | sed -e '2,${ /CHR/d }' | awk '$5>=0.05 {print $2}' > 1000G_Phase3_common.snps.txt
```

Now I want to intersect that file with the giant annotation file  I made above in order to just keep those SNPs

```shell
grep -wFf 1000G_Phase3_common.snps.txt final_baseline.atac_annot.txt > INCLUDE_SNPs_combined.annot.txt
```

Checking that the numbers match

```shell
wc -l INCLUDE_SNPs_combined.annot.txt 
5961160 INCLUDE_SNPs_combined.annot.txt #this includes a header so 5961160 SNPs which matches our previous numbers
```
Changing all delimiters to tabs and counting columns

```shell
sed 's/\  /\t/g' INCLUDE_snps_combined.annot.txt > final_include_snps_combined.annot.txt

head -1 final_include_snps_combined.annot.txt | tr ‘\t’ '\n' | wc -l
83
```
Now time to check to see if my “Prop._SNPs” match. Will use awk to pull out # of rows with 1s in each cell type and divide by 5961159

```shell
awk '$80==1 {print $1}' final_include_snps_combined.annot.txt | wc -l #rbp4
awk '$75==1 {print $1}' final_include_snps_combined.annot.txt | wc -l #DA-MB
awk '$67==1 {print $1}' final_include_snps_combined.annot.txt | wc -l #Ex1 single cell
awk '$65==1 {print $1}' final_include_snps_combined.annot.txt | wc -l #VIP-GABA
```

| Name | Prop._SNPs |  # SNPs | Calculated prop. |
|---|---|---|---|
| Rbp4 | 0.02921546 | 174158 | 0.02921546 |
| DA_MB | 0.017981067 | 107188 | 0.01798107 |
| Ex1 single cell | 0.003151401 | 18786 | 0.00315140059 |
|VIP GABA | 0.024506812 | 146089 | 0.0245068115 |  

Indeed they match! This indicates that I do have an annotation matrix for all SNPs that went in to the CTS segemented heritability calculations.

How many SNPs actually overlap one of my ATAC annotations? All of them?

```shell
awk '$83>=1 {print $1}' final_include_snps_combined.annot.txt | wc -l
539143

awk '$83==25 {print $1}' final_include_snps_combined.annot.txt | wc -l
2099

awk '$83==1 {print $1}' final_include_snps_combined.annot.txt | wc -l
243126
```
539143/5961159 = ~9% of common SNPs overlap with an open chromatin domain in at least one of my ATAC cell populations

2009/5961159 = ~0.03% of common SNPs overlap with open chromatin in all ATAC cell populations

243126/5961159 = ~4% of common SNPs overlap with an open chromatin domain in one and only one cell population



###7-26-18

I want to keep only the SNPs that actually intersect with an open chromatin domain. This will do two things for me: 1) keeping only the SNPs we care about; 2) make the dataframe much much much smaller

```shell
awk '$83>=1 {print $0}' final_include_snps_combined.annot.txt > overlap_snps_combined.annot.txt
```

```shell
awk '$58==1 && $83>1 {print $0}' overlap_snps_combined.annot.txt | wc -l
41412

awk '$58==1 && $83==1 {print $0}' overlap_snps_combined.annot.txt | wc -l
11074
```

###7-30-18

Delimiters were being weird so I 1) discovered the current delimiter was a space and 2) changed it to ","

```shell
awk '$1=$1' FS=" " OFS="," overlap_snps_combined.annot.txt > final_overlap_snps_combined.annot.txt
```

