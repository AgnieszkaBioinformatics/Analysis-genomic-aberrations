% sorting the bam files (control and tumor)

samtools sort Control.bam > Control.sorted.bam
samtools sort Tumor.bam > Tumor.sorted.bam

% Index the Sorted BAM File

samtools index Control.sorted.bam
samtools index Tumor.sorted.bam

% count the reads in the bam files

samtools view -c Control.sorted.bam
% out: 19720171
samtools view -c Tumor.sorted.bam
% out: 15039503

% count reads that map to reverse strand - the `-f 16` allows me to use the bitwise FLAG to filter the bam file

samtools view -c -f 16 Control.sorted.bam

samtools view -c -f 16 Tumor.sorted.bam
