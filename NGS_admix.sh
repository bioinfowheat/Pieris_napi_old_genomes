


# specify multiple chromosomes
nano chromosomes.txt
Chromosome_2:
Chromosome_3:
Chromosome_4:
Chromosome_5:
Chromosome_6:
Chromosome_7:
Chromosome_8:
Chromosome_9:
Chromosome_10:
Chromosome_11:
Chromosome_12:
Chromosome_13:
Chromosome_14:
Chromosome_15:
Chromosome_16:
Chromosome_17:
Chromosome_18:
Chromosome_19:
Chromosome_20:
Chromosome_21:
Chromosome_22:
Chromosome_23:
Chromosome_24:
Chromosome_25:

# paths needed
ANGSD=/cerberus/projects/chrwhe/software/angsd/angsd
NGSadmix=/cerberus/projects/chrwhe/software/angsd/misc/NGSadmix
BAMFOLDER=/cerberus/projects/chrwhe/Pieris_napi_old_demography/bams

# depth filtering
$ANGSD -bam all.files -GL 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 2e-6 -minMapQ 30 -minQ 20 -minInd 13 -minMaf 0.05 -doIBS 1 -doCounts 1 -doCov 1 -makeMatrix 1 -setMinDepth 50 -setMinDepthInd 5 -out all_mds_depth_filter -P 5 -rf chromosomes.txt
# -setMinDepth Discard site if total sequencing depth (all individuals added together) is below [int]. Requires -doCounts
# -setMinDepthInd
-> Output filenames:
	   ->"all_mds_depth_filter.arg"
	   ->"all_mds_depth_filter.mafs.gz"
	   ->"all_mds_depth_filter.ibs.gz"
	   ->"all_mds_depth_filter.ibsMat"
	   ->"all_mds_depth_filter.covMat"

# NGS admix run for all the different k numbers of populations
for i in {1..6} ; do echo $i ; done | cat | parallel -j 6 "$NGSadmix -likes all_mds_depth_filter_ngsadmix.beagle.gz -K {} -minMaf 0.05 -seed 1 -o all_mds_depth_filter_ngsadmix.{}_pops"
