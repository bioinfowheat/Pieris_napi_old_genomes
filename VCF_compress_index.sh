###################################################################################################
###################################################################################################
## compressing and indexing all the final vcf files
###################################################################################################
###################################################################################################

# bgzip all.sorted_gt3.merged.sorted.readdepth_lt_4.N_repeat.merged.bed
# tabix all.sorted_gt3.merged.sorted.readdepth_lt_4.N_repeat.merged.bed.gz
#
# SNPs.filtered.final.recode.vcf

parallel 'bgzip {}' ::: *SNPs.filtered.final.recode.vcf
parallel 'tabix {}' ::: *SNPs.filtered.final.recode.vcf.gz
