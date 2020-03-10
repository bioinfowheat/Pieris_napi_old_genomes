# add read groups to the bam files, as freebayes needs this information for
# calling the SNPs.

# importantly, if you have more than one sequencing dataset / individual
# these would be each mapped against the same reference, but exist as
# two different bam files, so that their read particularities could be
# accurately modeled by freebayes

# make metadata file
# 1 simple_ID
# 2 sample_ID
# 3 instrument
# 4 seq number
# 5 run number
# 6 flow cell
# 7 lane
# 8 barcode

# from SciLife
	# what I need you to add are the columns, using data from the scilife files they sent you.
	#
	# # 6 flow cell (Important, looks like this and is found in the sequenceing file from scilife, BHJ7J7DSXX )
	# # 7 lane (important )
	# # 8 barcode (Important, looks like ATTACTCG-TATAGCCT , and is found in the scilife metadata file and is the index)
	#
	# this will be in the *_lanes_info.txt file, where you want FC_id and Lane
	#
	# example file
	# Date  FC id Lane
	# Cluster(M) Phix
	# >=Q30(%) Method
	# 190610  AHK2CFDSXX 1
	# 2709.1 0.28
	# 87.66 A
	#
	# FC_id = flow_cell = AHK2CFDSXX
	# Lane = 1
	#
	# and the *_library_info.txt files
	# example file
	# NGI ID  Index Lib Prep
	# Avg. FS Lib QC
	# P12863_101  SI-GA-A7 (ACAGAGGT_TATAGTTG_CGGTCCCA_GTCCTAAC)
	# A 632.39
	# PASSED
	#
	# barcode = Index = ACAGAGGT_TATAGTTG_CGGTCCCA_GTCCTAAC

# revised metadata on samples
	# short_name	bam_filename	population	Region	sample_year	Instrument	seq_number	run_number	flow_cell	lane	barcode
	# Dal_01	54.8.sorted.bam	pop5	Dalarna	1954	Illumina	1	123
	# Dal_02	54.5.sorted.bam	pop5	Dalarna	1954	Illumina	1	123
	# Got_01	41.6.sorted.bam	pop6	Götland	1941	Illumina	1	123
	# Sto_01	Pn18.sorted.bam	pop4	Stockholm	1918	Illumina	1	123	AHWL3JCCXY	2	CCTTAAT
	# Sto_02	Pn83.sorted.bam	pop4	Stockholm	1885	Illumina	1	123	AHWL3JCCXY	2	TTCCGAG
	# Sto_03	Pn22.sorted.bam	pop4	Stockholm	1922	Illumina	1	123	AHWL3JCCXY	2	TGCGTCC
	# Ska_01	Pn89.sorted.bam	pop3	Skåne	1989	Illumina	1	123	BHWLW3CCXY	4	CGACCTG
	# Ska_02	Pn85.sorted.bam	pop3	Skåne	1985	Illumina	1	123	AHWL3JCCXY	2	AAGGTCT
	# Ska_03	Pn06.sorted.bam	pop3	Skåne	1906	Illumina	1	123	AHWL3JCCXY	2	GGCATAG
	# Ska_04	41.3.sorted.bam	pop3	Skåne	1941	Illumina	1	123
	# Den_01	Pn09.sorted.bam	pop2	Denmark	1909	Illumina	1	123	AHWL3JCCXY	2	CTCCAGT
	# Abo_01	Pn1900.sorted.bam	pop1	Abisko	1900	Illumina	1	123	AHWL3JCCXY	2	AGAGCGC
	# Abo_02	47.6.sorted.bam	pop1	Abisko	1947	Illumina	1	123
	#
	#
	# For the samples 54.5 41.3 41.6 54.8 data from both a miseq and hiseq run were combined. I added the flow cell info for the miseq as well (I just added all the info under the table, as wasn’t sure how to incorporate this into yours). The same libraries were sequenced on both
	#
	# For sample 47.6 it’s a bit more complicated. We also have both hiseq and miseq data. But in addition we sequenced 2 independent libraries for this specimen (2 different extraction methods were tested). So for that we have 2 different barcodes, this data was also combined for this analysis.
	# 	Miseq flow_cell	Hiseq_flow_cell	lane	barcode
	# 47.6	000000000-B6F5F	AHJF3YCCXY	8	TCGCAGG
	# 47.6	000000000-B6F5F	AHJF3YCCXY	8	CTCTGCA
	# 54.5	000000000-B6F5F	AHJF3YCCXY	8	ATGGAGA
	# 41.3	000000000-B6F5F	AHJF3YCCXY	8	GAATCTC
	# 41.6	000000000-B6F5F	AHJF3YCCXY	8	CGACCTG
	# 54.8	000000000-B6F5F	AHJF3YCCXY	8	GACTTCT


	# 6 flow cell (Important, looks like this and is found in the sequenceing file from scilife,
	# BHJ7J7DSXX )
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
