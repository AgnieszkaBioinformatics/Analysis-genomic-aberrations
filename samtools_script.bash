% sorting the bam files (control and tumor)

samtools sort Control.bam > Control.sorted.bab
samtools sort Tumor.bam > Tumor.sorted.bam

% Index the Sorted BAM File

samtools index Control.sorted.bam
samtools index Tumor.sorted.bam


