
# using the new readgroup files from the add_readgroups_freebayes.sh result

# index
samtools index Abisko*.sorted.rg.bam

# and for parallel, excluding Abisko which were run already
ls *rg.bam | grep -v 'Abisko' | parallel --dryrun "samtools index {}"


	
