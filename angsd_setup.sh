####
#
# http://evomics.org/learning/population-and-speciation-genomics/2018-population-and-speciation-genomics/angsd-activity-admixture-population-structure/
#
# http://www.popgen.dk/software/index.php/NgsAdmix


#
# MDS
ANGSD=/cerberus/projects/chrwhe/software/angsd/angsd
NGSadmix=/cerberus/projects/chrwhe/software/angsd/misc/NGSadmix
BAMFOLDER=/cerberus/projects/chrwhe/Pieris_napi_old_demography/bams

# get bam file list
find $BAMFOLDER |  grep bam$ > all.files

# identify the chromosomes or scaffolds to infer SNPs upon
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


# run angsd
$ANGSD -bam all.files -GL 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 2e-6 -minMapQ 30 -minQ 20 -minInd 13 -minMaf 0.05 -doGlf 2 -doCounts 1 -setMinDepth 50 -setMinDepthInd 5 -out all_mds_depth_filter_ngsadmix -P 10 -rf chromosomes.txt

# compared to NGSadmix, I got better results for my data using a
# PCA based aproach, which I detail below.

https://github.com/Rosemeis/pcangsd

# with details here
http://www.popgen.dk/software/index.php/PCAngsd


# PCangsd
cd /cerberus/projects/chrwhe/software
git clone https://github.com/Rosemeis/pcangsd.git

pcangsd_path=/cerberus/projects/chrwhe/software/pcangsd


# Estimate covariance matrix and individual admixture proportions
python $pcangsd_path/pcangsd.py -beagle all_mds_depth_filter_ngsadmix.beagle.gz -admix -o admix_nok -threads 30

# here you can specify the exact number of populations you wish to infer, setting k (-admix_K).
# but this is not recommended, and the methods above should generate what it thinkgs is the best k
# see manual page: Not recommended. Manually specify the number of ancestral populations to use in admixture estimations (overrides number chosen from -e). Structure explained by individual allele frequencies may therefore not reflect the manually chosen K. It is recommended to adjust -e instead
# and if -e is not set, it automatically tests different eigenvalues (k) using MAP test
python $pcangsd_path/pcangsd.py -beagle all_mds_depth_filter_ngsadmix.beagle.gz -admix -admix_K 2 -o admix_k2 -threads 30








#
