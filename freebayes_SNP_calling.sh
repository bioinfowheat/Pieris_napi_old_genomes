# freebayes SNP calling

cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams


# paths that need to be defined for running bcftools and freebayes
export PATH=$PATH:/data/programs/bcftools-1.3.1:/data/programs/freebayes/bin/


# make a file with the lengths of the chromosomes to call VCF for
# here I only chose chromosomes 2 through 20.
nano chromosomes_2_25.bed
Chromosome_2 1 15427984
Chromosome_3 1 15357576
Chromosome_4 1 14845049
Chromosome_5 1 14436900
Chromosome_6 1 13738639
Chromosome_7 1 14186557
Chromosome_8 1 14068971
Chromosome_9 1 13996725
Chromosome_10 1 13801688
Chromosome_11 1 13587546
Chromosome_12 1 12815933
Chromosome_13 1 12634055
Chromosome_14 1 12597868
Chromosome_15 1 12489475
Chromosome_16 1 11837383
Chromosome_17 1 11817185
Chromosome_18 1 11702215
Chromosome_19 1 10907953
Chromosome_20 1 10776756
Chromosome_21 1 10581609
Chromosome_22 1 9085402
Chromosome_23 1 6692213
Chromosome_24 1 5861113
Chromosome_25 1 4833285

VCF=
VCF_root=$(echo $VCF | )

# remove SNPs within 3 bp of indel
bcftools filter -g3 -O u $VCF > abisko.freebayes.bcf

# remove indels and keep biallelic SNPs with overall QUAL > 40
bcftools view -O v -m 2 -M 2 --types snps -i 'QUAL>40' abisko.freebayes.bcf >abisko.freebayes.SNPs.vcf

# set genotypes to missing based on depth, and a maximum missing treshold 5%
vcftools --vcf abisko.freebayes.SNPs.vcf --minDP 4 --maxDP 80 --max-missing 0.95 --recode --out abisko.freebayes.SNPs.filtered.final

# final vcf file.
abisko.freebayes.SNPs.filtered.final.recode.vcf


# 20 chromosomes
export PATH=$PATH:/data/programs/bcftools-1.3.1:/data/programs/freebayes/bin/
freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -t chromosomes_2_20.bed AbiskoPn1900.sorted.rg.bam Abisko47.6.sorted.rg.bam > abisko.freebayes_chr20.vcf
bcftools filter -g3 -O u abisko.freebayes_chr20.vcf > abisko.freebayes_chr20.bcf
bcftools view -O v -m 2 -M 2 --types snps -i 'QUAL>40' abisko.freebayes_chr20.bcf >abisko.freebayes_chr20.SNPs.vcf
vcftools --vcf abisko.freebayes_chr20.SNPs.vcf --minDP 4 --maxDP 80 --max-missing 0.95 --recode --out abisko.freebayes_chr20.SNPs.filtered.final

# now the other samples
cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams





#
