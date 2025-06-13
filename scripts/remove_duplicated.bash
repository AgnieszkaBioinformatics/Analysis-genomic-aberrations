#remove duplicates
Picard MarkDuplicates I=Control.sorted.realigned.recalibrated.bam O=Control.sorted.realigned.recalibrated.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Control.sorted.realigned.recalibrated.picard.log ASSUME_SORTED=true
samtools index Control.sorted.realigned.recalibrated.dedup.bam
samtools flagstat Control.sorted.realigned.recalibrated.dedup.bam

Picard MarkDuplicates I=Tumor.sorted.realigned.recalibrated.bam O=Tumor.sorted.realigned.recalibrated.dedup.bam REMOVE_DUPLICATES=true TMP_DIR=/tmp METRICS_FILE=Tumor.sorted.realigned.recalibrated.picard.log ASSUME_SORTED=true
samtools index Tumor.sorted.realigned.recalibrated.dedup.bam
samtools flagstat Tumor.sorted.realigned.recalibrated.dedup.bam
