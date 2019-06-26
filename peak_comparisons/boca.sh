#!/bin/bash

wget https://bendlj01.u.hpc.mssm.edu/multireg/resources/boca_peaks.zip
unzip boca_peaks.zip

mkdir boca_processed

for i in `ls -v *neuron.bed`; do cut -f 1-3 $i > boca_processed/processed_${i}; done

cd boca_processed

grep -s "1.1e+08" * .* #this is in processed_PUT_neuron.bed

sed -e 's/1.1e+08/110000000/g' processed_PUT_neuron.bed > mod_processed_PUT_neuron.bed 

rm processed_PUT_neuron.bed

cat * | sort -k1,1 -k2,2n > sorted_boca_neurons.bed

bedtools --version
bedtools merge -i sorted_boca_neurons.bed > merged_boca_neurons.bed

rm ../boca_peaks.zip

exit 0
