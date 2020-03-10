freebayes SNP calling

cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams

# make metadata file
Abisko_01 AbiskoPn1900.sorted.bam Illumina 1 206 HJ5WKCCXY 7 TCCGGAGA+GTCAGTAC
Abisko_02 Abisko47.6.sorted.bam  Illumina 1 1 BHJ7J7DSXX 2 ATTACTCG-TATAGCCT

nano metadata_whole.tsv

./add_readgroups_freebayes.sh  # to add the read names to these files

# index
samtools index Abisko*.sorted.rg.bam

# the run freebayes
export PATH=$PATH:/data/programs/bcftools-1.3.1:/data/programs/freebayes/bin/

# freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta AbiskoPn1900.sorted.bam Abisko47.6.sorted.bam > abisko.freebayes.vcf

-r Chromosome_2
-t chromosomes_2_10.bed

nano chromosomes_2_10.bed
Chromosome_2 1 15427984
Chromosome_3 1 15357576
Chromosome_4 1 14845049
Chromosome_5 1 14436900
Chromosome_6 1 13738639
Chromosome_7 1 14186557
Chromosome_8 1 14068971
Chromosome_9 1 13996725
Chromosome_10 1 13801688
Chromosome_11 1 13587546
Chromosome_12 1 12815933
Chromosome_13 1 12634055
Chromosome_14 1 12597868
Chromosome_15 1 12489475
Chromosome_16 1 11837383
Chromosome_17 1 11817185
Chromosome_18 1 11702215
Chromosome_19 1 10907953
Chromosome_20 1 10776756

# test run on only chromo 2
freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -t chromosomes_2.bed AbiskoPn1900.sorted.rg.bam Abisko47.6.sorted.rg.bam > abisko.freebayes.vcf


# remove SNPs within 3 bp of indel
bcftools filter -g3 -O u abisko.freebayes.vcf > abisko.freebayes.bcf

# remove indels and keep biallelic SNPs with overall QUAL > 40
bcftools view -O v -m 2 -M 2 --types snps -i 'QUAL>40' abisko.freebayes.bcf >abisko.freebayes.SNPs.vcf

# set genotypes to missing based on depth, and a maximum missing treshold 5%
vcftools --vcf abisko.freebayes.SNPs.vcf --minDP 4 --maxDP 80 --max-missing 0.95 --recode --out abisko.freebayes.SNPs.filtered.final

# final vcf file.
abisko.freebayes.SNPs.filtered.final.recode.vcf


# 20 chromosomes
export PATH=$PATH:/data/programs/bcftools-1.3.1:/data/programs/freebayes/bin/
freebayes -f /cerberus/projects/shared_napi_rapae/assemblies/Pieris_napi_fullAsm_chomoOnly.fasta -t chromosomes_2_20.bed AbiskoPn1900.sorted.rg.bam Abisko47.6.sorted.rg.bam > abisko.freebayes_chr20.vcf
bcftools filter -g3 -O u abisko.freebayes_chr20.vcf > abisko.freebayes_chr20.bcf
bcftools view -O v -m 2 -M 2 --types snps -i 'QUAL>40' abisko.freebayes_chr20.bcf >abisko.freebayes_chr20.SNPs.vcf
vcftools --vcf abisko.freebayes_chr20.SNPs.vcf --minDP 4 --maxDP 80 --max-missing 0.95 --recode --out abisko.freebayes_chr20.SNPs.filtered.final

# now the other samples
cd /cerberus/projects/chrwhe/Pieris_napi_old_demography/bams

# make metadata file
# 1 simple_ID
# 2 sample_ID
# 3 instrument
# 4 seq number
# 5 run number
# 6 flow cell
# 7 lane
# 8 barcode
Abisko_01 AbiskoPn1900.sorted.bam Illumina 1 206 HJ5WKCCXY 7 TCCGGAGA+GTCAGTAC
Abisko_02 Abisko47.6.sorted.bam  Illumina 1 1 BHJ7J7DSXX 2 ATTACTCG-TATAGCCT

# revised metadata on samples
short_name	bam_filename	population	Region	sample_year	Instrument	seq_number	run_number	flow_cell	lane	barcode
Dal_01	54.8.sorted.bam	pop5	Dalarna	1954	Illumina	1	123
Dal_02	54.5.sorted.bam	pop5	Dalarna	1954	Illumina	1	123
Got_01	41.6.sorted.bam	pop6	Götland	1941	Illumina	1	123
Sto_01	Pn18.sorted.bam	pop4	Stockholm	1918	Illumina	1	123	AHWL3JCCXY	2	CCTTAAT
Sto_02	Pn83.sorted.bam	pop4	Stockholm	1885	Illumina	1	123	AHWL3JCCXY	2	TTCCGAG
Sto_03	Pn22.sorted.bam	pop4	Stockholm	1922	Illumina	1	123	AHWL3JCCXY	2	TGCGTCC
Ska_01	Pn89.sorted.bam	pop3	Skåne	1989	Illumina	1	123	BHWLW3CCXY	4	CGACCTG
Ska_02	Pn85.sorted.bam	pop3	Skåne	1985	Illumina	1	123	AHWL3JCCXY	2	AAGGTCT
Ska_03	Pn06.sorted.bam	pop3	Skåne	1906	Illumina	1	123	AHWL3JCCXY	2	GGCATAG
Ska_04	41.3.sorted.bam	pop3	Skåne	1941	Illumina	1	123
Den_01	Pn09.sorted.bam	pop2	Denmark	1909	Illumina	1	123	AHWL3JCCXY	2	CTCCAGT
Abo_01	Pn1900.sorted.bam	pop1	Abisko	1900	Illumina	1	123	AHWL3JCCXY	2	AGAGCGC
Abo_02	47.6.sorted.bam	pop1	Abisko	1947	Illumina	1	123


For the samples 54.5 41.3 41.6 54.8 data from both a miseq and hiseq run were combined. I added the flow cell info for the miseq as well (I just added all the info under the table, as wasn’t sure how to incorporate this into yours). The same libraries were sequenced on both

For sample 47.6 it’s a bit more complicated. We also have both hiseq and miseq data. But in addition we sequenced 2 independent libraries for this specimen (2 different extraction methods were tested). So for that we have 2 different barcodes, this data was also combined for this analysis.
	Miseq flow_cell	Hiseq_flow_cell	lane	barcode
47.6	000000000-B6F5F	AHJF3YCCXY	8	TCGCAGG
47.6	000000000-B6F5F	AHJF3YCCXY	8	CTCTGCA
54.5	000000000-B6F5F	AHJF3YCCXY	8	ATGGAGA
41.3	000000000-B6F5F	AHJF3YCCXY	8	GAATCTC
41.6	000000000-B6F5F	AHJF3YCCXY	8	CGACCTG
54.8	000000000-B6F5F	AHJF3YCCXY	8	GACTTCT


# 6 flow cell (Important, looks like this and is found in the sequenceing file from scilife, BHJ7J7DSXX )
# 7 lane (important )
# 8 barcode (Probably important, looks like ATTACTCG-TATAGCCT , and is found in the scilife metadata file)

nano metadata_whole_others.tsv
# here is my composite metadata file, perhaps not the best, but OK.

Dal_01	54.8.sorted.bam	Illumina	1	123	HJ5WKCCXY		1	GACTTCT
Dal_02	54.5.sorted.bam	Illumina	1	123	HJ5WKCCXY		1	ATGGAGA
Got_01	41.6.sorted.bam	Illumina	1	123	HJ5WKCCXY		1	CGACCTG
Sto_01	Pn18.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	CCTTAAT
Sto_02	Pn83.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	TTCCGAG
Sto_03	Pn22.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	TGCGTCC
Ska_01	Pn89.sorted.bam	Illumina	1	123	BHWLW3CCXY	4	CGACCTG
Ska_02	Pn85.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	AAGGTCT
Ska_03	Pn06.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	GGCATAG
Ska_04	41.3.sorted.bam	Illumina	1	123	HJ5WKCCXY		1	GAATCTC
Den_01	Pn09.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	CTCCAGT
Abo_01	Pn1900.sorted.bam	Illumina	1	123	AHWL3JCCXY	2	AGAGCGC
Abo_02	47.6.sorted.bam	Illumina	1	123	HJ5WKCCXY		1	TCGCAGG

./add_readgroups_freebayes.sh  # to add the read names to these files



#