library(here)
library(dplyr)
library(reshape2)
library(GenomicRanges)
library(GenomicAlignments)
library(XVector)
library(myvariant)
library(proxysnps)

table3.bed <- here::here("Pardinas_TableS3_new.txt")
lead.snps.df <- read.delim(table3.bed,
                           sep = "\t",
                           stringsAsFactors = F,header = F,
                           col.names = c("chr","start","end","lead.snp","search.snp")) %>%
  dplyr::filter(lead.snp != "rs3130820") #mhc locus removal just to be sure

lead.snps <- lead.snps.df$lead.snp
search.snps <- lead.snps.df$search.snp

for(i in 1:length(lead.snps)) {
   tmp<-get_proxies(query = search.snps[i],window_size = 2e6,pop = "EUR") %>%
	dplyr::filter(R.squared >= 0.1, MAF >= 0.01) %>% 
	dplyr::mutate(lead.snp=lead.snps[i])
   write.table(tmp,file=paste0(lead.snps[i],".proxy-snps.new.txt"),sep="\t",quote=F,col.names=F,row.names=F)
}



