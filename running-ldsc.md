###Making annotation files
```shell
for chr in {1..22}
do
	python ~/ldsc/make_annot.py \
    --bed-file $BED \
    --bimfile ../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr}.bim \
    --annot-file ${BED%.bed}.${chr}.annot.gz
done
```

###Computing LD score of ATAC-seq peak files

```shell
CELL=$1
CTS_DIR=~/data/PWH/public_atac_data/atac-data/ldsc/cts/atac_cell_type
LDSC_DIR=~/my-python-modules/ldsc
```

```shell
for chr in {1..22}
do
	$LDSC_DIR/ldsc.py \
    --print-snps ../../1000G_EUR_Phase3_baseline/print_snps.txt \
    --ld-wind-cm 1.0 \
    --out ${CELL}.${chr} \
    --bfile ../../1000G_EUR_Phase3_plink/1000G.EUR.QC.${chr} \
    --thin-annot \
    --annot ${CELL}.${chr}.annot.gz \
    --l2
done
```

###Running CTS LDSC
```shell
SUMSTAT=$1

$LDSC_DIR/ldsc.py \
    --h2-cts $SUM_DIR/$SUMSTAT \
    --ref-ld-chr ../1000G_EUR_Phase3_baseline/baseline. \
    --out $OUT_DIR/new_${SUMSTAT%.sumstats.gz}_Hook_ATAC \
    --ref-ld-chr-cts $CTS_DIR/Hook_ATAC.ldct \
    --w-ld-chr ../1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC.
```