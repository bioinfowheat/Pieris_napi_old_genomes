###################################################################################################
###################################################################################################
## smc++ demographic inference
###################################################################################################
###################################################################################################

# populations
	# Dal_01	pop5
	# Dal_02	pop5
	# Got_01	pop6
	# Sto_01	pop4
	# Sto_02	pop4
	# Sto_03	pop4
	# Ska_01	pop3
	# Ska_02	pop3
	# Ska_03	pop3
	# Ska_04	pop3
	# Den_01	pop2
	# Abisko_01	pop1
	# Abisko_02	pop1

# populations reformatted
	# pop1:Abisko_01,Abisko_02
	# pop2:Den_01
	# pop3:Ska_01,Ska_02,Ska_03,Ska_04
	# pop4:Sto_01,Sto_02,Sto_03
	# pop5:Dal_01,Dal_02
	# pop6:Got_01


################################################
# generate the input files for smc++
################################################

# VCF=/usit/abel/u1/mortema/vcf/freebayes.ALL.VAR.Q40.DP4_30_max_miss_5.recode.edit.annotated.names.SNPs.AA.vcf.gz
# for pop_south in GF01 GF49 TV69 TV70;do
#     while read line;do
# /usit/abel/u1/mortema/miniconda3/bin/smc++ vcf2smc -d $pop_south $pop_south $VCF SOUTH/$pop_south.$line.smc.gz $line South:GF28,GF03,GF05,GF02,GF23,GF38,GF49,GF01,GF07,GF04,TV66,TV67,TV69,TV65,TV68,TV73,TV74,TV70,AR63,AR68,AR64,AR65,AR67,AR66,AR62,AR61
# done < /usit/abel/u1/mortema/vcf/contigs_1MB
# done

# this is set up for chromosomes 2 to 25
# these are all separate now
# all.freebayes.Chromosome_16.SNPs.filtered.final.recode.vcf
# all.freebayes.Chromosome_22.SNPs.filtered.final.recode.vcf

mask_file=all.sorted_gt3.merged.sorted.readdepth_lt_4.N_repeat.merged.bed.gz

# pop1
mkdir pop1
for pop1 in Abisko_01 Abisko_02;do
	for i in {2..25} ; do echo $i ; done | cat | parallel "smc++ vcf2smc -d $pop1 $pop1 all.freebayes.Chromosome_{}.SNPs.filtered.final.recode.vcf.gz pop1/$pop1.Chromosome_{}.smc.txt Chromosome_{} --mask $mask_file pop1:Abisko_01,Abisko_02"
done


# pop2
mkdir pop2
for pop2 in Den_01;do
	for i in {2..25} ; do echo $i ; done | cat | parallel "smc++ vcf2smc -d $pop2 $pop2 all.freebayes.Chromosome_{}.SNPs.filtered.final.recode.vcf.gz pop2/$pop2.Chromosome_{}.smc.txt Chromosome_{} --mask $mask_file pop2:Den_01"
done

# pop3
mkdir pop3
for pop3 in Ska_01 Ska_02 Ska_03 Ska_04;do
	for i in {2..25} ; do echo $i ; done | cat | parallel "smc++ vcf2smc -d $pop3 $pop3 all.freebayes.Chromosome_{}.SNPs.filtered.final.recode.vcf.gz pop3/$pop3.Chromosome_{}.smc.txt Chromosome_{} --mask $mask_file pop3:Ska_01,Ska_02,Ska_03,Ska_04"
done

# pop4
mkdir pop4
for pop4 in Sto_01 Sto_02 Sto_03;do
	for i in {2..25} ; do echo $i ; done | cat | parallel "smc++ vcf2smc -d $pop4 $pop4 all.freebayes.Chromosome_{}.SNPs.filtered.final.recode.vcf.gz pop4/$pop4.Chromosome_{}.smc.txt Chromosome_{} --mask $mask_file pop4:Sto_01,Sto_02,Sto_03"
done
