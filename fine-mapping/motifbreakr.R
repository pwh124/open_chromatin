library(motifbreakR)
library(BSgenome.Hsapiens.UCSC.hg19)

all.variants.df <- readRDS("allVariants.Rds")

results <- motifbreakR(snpList = all.variants.df,
                       filterp = TRUE,
                       pwmList = hocomoco,
                       verbose = TRUE,
                       threshold = 1e-4,
                       method = "ic",
                       bkg = c(A=0.25, C=0.25, G=0.25, T=0.25),
                       BPPARAM = BiocParallel::MulticoreParam(workers=22))

saveRDS(results,"allResults.Rds")
