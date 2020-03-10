#########
# here we are going to combine a series of bed files
# to mask out the regions of the genome where
# the genome is N, there is repetitive content, and the read depth is low

# get the depths for all the bam files
parallel "bedtools genomecov -ibam {} -bg  > {.}.bed" ::: Abisko*sorted.bam

# filter these for having depth > 3
parallel "awk '$4 > 3' {} > {.}.gt3.bed" ::: *.bed

# combine all
cat *.gt3.bed | sort -k1,1 -k2,2n > all.sorted_gt3.bed

# need file of chromosome sizes
more chromo_sizes.tsv
Chromosome_1    11357067
Chromosome_2    15427984
Chromosome_3    15357576
Chromosome_4    14845049
Chromosome_5    14436900
Chromosome_6    13738639
Chromosome_7    14186557
Chromosome_8    14068971
Chromosome_9    13996725
Chromosome_10   13801688
Chromosome_11   13587546
Chromosome_12   12815933
Chromosome_13   12634055
Chromosome_14   12597868
Chromosome_15   12489475
Chromosome_16   11837383
Chromosome_17   11817185
Chromosome_18   11702215
Chromosome_19   10907953
Chromosome_20   10776756
Chromosome_21   10581609
Chromosome_22   9085402
Chromosome_23   6692213
Chromosome_24   5861113
Chromosome_25   4833285

# merge
bedtools merge -i all.sorted_gt3.bed | bedtools complement -i - -g chromo_sizes.tsv > all.sorted_gt3.merged.readdepth_lt_4.bed


# # make N regions of the genome
# https://www.danielecook.com/generate-a-bedfile-of-masked-ranges-a-fasta-file/
# ln -s /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta Pieris_napi_fullAsm_chomoOnly.fa
# python generate_masked_ranges.py Pieris_napi_fullAsm_chomoOnly.fa Chromosome_ Chromosome_ > Pieris_napi_fullAsm_chomoOnly.Nmask.bed

genome_Ns=/cerberus/projects/chrwhe/Pieris_napi_old_demography/Pieris_napi_fullAsm_chomoOnly.Nmask.bed

# get the repeat file for the reference
genome_repeats=/cerberus/projects/chrwhe/Pieris_napi_old_demography/repeatmasker.gff.bed.gz

# combine
zcat $genome_repeats | cut -f1,2,3 | cat - $genome_Ns all.sorted_gt3.merged.readdepth_lt_4.bed | \
sort -k1,1 -k2,2n | \
# merge all these overlapping beds
cut -f1,2,3 | bedtools merge > all.sorted_gt3.merged.readdepth_lt_4.N_repeat.merged.bed

# compress and index
bgzip all.sorted_gt3.merged.readdepth_lt_4.N_repeat.merged.bed
tabix all.sorted_gt3.merged.readdepth_lt_4.N_repeat.merged.bed.gz






#
