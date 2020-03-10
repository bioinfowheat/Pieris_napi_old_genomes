#!/bin/bash
# parallel

# run example
#
# ./freebayes_parallel_by_chromosome.sh chromosomes_2_25.bed

# for parallel, one vcf per chromosome
export PATH=$PATH:/data/programs/freebayes/bin/

while read p; do
	chromo_name=$(echo $p | cut -f1 -d ' ')
	nohup freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -r $chromo_name -L bam_file_list > all.freebayes.$chromo_name.vcf &>/dev/null &
done < $1
