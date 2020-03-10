######
# PCR duplicate removal
# following https://github.com/mattingsdal/Population-genomics/blob/master/02.Picard.sh

############################################################
### mark duplicates using picard
### be in bam rgfix directory


# serial
# for D in *bam
# do
#   output=$(echo $D | awk '{gsub(".bam","",$0); print;}')
#   java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar MarkDuplicates INPUT=$D OUTPUT=../bam_fixrg_dedup/$output.dedup.bam METRICS_FILE=../bam_fixrg_dedup/QC/$output.duplicates REMOVE_DUPLICATES=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=10
# done

# parallel script
mkdir bam_fixrg_dedup
mkdir bam_fixrg_dedup/QC
parallel "java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar MarkDuplicates INPUT={} OUTPUT=bam_fixrg_dedup/{.}.dedup.bam METRICS_FILE=bam_fixrg_dedup/QC/{.}.duplicates REMOVE_DUPLICATES=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=10" ::: *.rg.bam


### end mark duplicates
############################################################
############################################################
### produce QC stats using picard for all bam files and place results in QC sub-folder
###
for D in *bam
do

  output=$(echo $D | cut -f 1,2,3,4 -d .)
  java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar CollectAlignmentSummaryMetrics I=$D R=~/data/symphodus_melops.fasta O=QC/$output.CollectAlignmentSummaryMetrics.txt
  java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar CollectInsertSizeMetrics I=$D O=QC/$output.CollectInsertSizeMetrics.txt M=0.5 H=QC/$output.CollectInsertSizeMetrics.pdf
  java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar CollectGcBiasMetrics I=$D O=QC/$output.CollectGcBiasMetrics.txt CHART=QC/$output.CollectGcBiasMetrics.pdf S=QC/$output.CollectGcBiasMetrics.summary.txt R=~/data/symphodus_melops.fasta
  java -Xmx10g  -jar /data/programs/picard-tools-1.139/picard.jar QualityScoreDistribution I=$D O=QC/$output.QualityScoreDistribution.txt CHART=QC/$output.QualityScoreDistribution.pdf

done
### end QC info
############################################################
