#!/bin/bash
# parallel

# run example
#
# ./freebayes_parallel_by_chromosome.sh chromosomes_2_25
#
# where the chromosomes_2_25 is just a list of the scaffold IDs in the assembly
# I want to call vcf for
# this uses a fixed list of bam files: bam_file_list
# and the P. napi genome

# for parallel, one vcf per chromosome
export PATH=$PATH:/data/programs/freebayes/bin/


cat $1 | parallel "freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -r {} -L bam_file_list > all.freebayes.{}.vcf"
