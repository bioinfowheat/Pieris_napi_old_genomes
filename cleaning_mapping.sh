# information from NW lab
#
#Data Cleaning 1 - Prinseq for N removal
prinseq-lite.pl -fastq $R1 -out_format 3 -ns_max_n 0 -out_bad null -out_good $out_R1
prinseq-lite.pl -fastq $R2 -out_format 3 -ns_max_n 0 -out_bad null -out_good $out_R2

#Data Cleaning 2 - Trimmomatic for adapter removal, quality filtering
trimmomatic SE -threads 10 $InR1 $OutR1 ILLUMINACLIP:TruSeq_mine.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:30

trimmomatic SE -threads 10 $InR2 $OutR2 ILLUMINACLIP:TruSeq_mine.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:30

#Mapping to Pieris genome - Bowtie2 (CSC)
#Build index
bowtie2-build Pieris_napi.fasta Pieris_napi
#Map Reads, ensuring unmapped reads are not written to file
bowtie2 -p $SLURM_CPUS_PER_TASK --very-sensitive-local --no-unal -x $genome -U $reads --un-gz $unalign -S $code.sam
