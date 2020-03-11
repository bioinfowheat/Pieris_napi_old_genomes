#


# in folder
cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams/rg_files

# ls *.vcf | parallel --dryrun "./SNPfilter.sh {} "

ls *.vcf | parallel "./SNPfilter.sh {} "
