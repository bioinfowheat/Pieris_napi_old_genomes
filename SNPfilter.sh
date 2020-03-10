#!/bin/bash
#########
# filer of freebayes vcf file
# removes indels, filters on quality
# based upon https://github.com/mattingsdal/Population-genomics/blob/master/05.SNPfilter.sh

export PATH=$PATH:/data/programs/bcftools-1.3.1:

VCF=$1

VCF_root=$(echo $VCF | awk '{gsub(".vcf","",$0); print;}')

# remove SNPs within 3 bp of indel
bcftools filter -g3 -O u $VCF > $VCF_root.bcf

# remove indels and keep biallelic SNPs with overall QUAL > 40
bcftools view -O v -m 2 -M 2 --types snps -i 'QUAL>40' $VCF_root.bcf > $VCF_root.SNPs.vcf

# set genotypes to missing based on depth, and a maximum missing treshold 5%
vcftools --vcf $VCF_root.SNPs.vcf --minDP 4 --maxDP 80 --max-missing 0.95 --recode --out $VCF_root.SNPs.filtered.final
