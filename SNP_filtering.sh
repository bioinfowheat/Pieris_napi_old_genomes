#


# in folder
cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams/rg_files

# ls *.vcf | parallel --dryrun "./SNPfilter.sh {} "

ls *.vcf | parallel "./SNPfilter.sh {} "

# results look like about 25% of SNPs are kept per chromosome

# --out all.freebayes.Chromosome_4.SNPs.filtered.final
# After filtering, kept 155249 out of a possible 427470 Sites
# 
# --out all.freebayes.Chromosome_10.SNPs.filtered.final
# After filtering, kept 158554 out of a possible 437184 Sites
#
# --out all.freebayes.Chromosome_3.SNPs.filtered.final
# After filtering, kept 163581 out of a possible 446542 Sites
#
# --out all.freebayes.Chromosome_2.SNPs.filtered.final
# After filtering, kept 183271 out of a possible 472010 Sites
