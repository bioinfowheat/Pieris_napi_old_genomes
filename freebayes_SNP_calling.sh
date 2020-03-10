# freebayes SNP calling

cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams



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

# bam file list
ls *.rg.bam > bam_file_list

# calling SNPs across 25 chromosomes
# path to freebayes
export PATH=$PATH:/data/programs/freebayes/bin/
#
# serial through all chromosomes on one core
freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -t chromosomes_2_25.bed -L bam_file_list > all.freebayes_chr25.vcf

# or use parallel code
#
# freebayes_parallel_by_chromosome.sh chromosomes_2_25.bed






#
