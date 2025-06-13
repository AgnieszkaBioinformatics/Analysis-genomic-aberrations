samtools mpileup -q 1 -f ../../Annotations/human_g1k_v37.fasta Control.sorted.realigned.recalibrated.dedup.bam Tumor.sorted.realigned.recalibrated.dedup.bam 
VarScan copynumber --output-file SCNA --mpileup 1
VarScan copyCaller SCNA.copynumber --output-file SCNA.copynumber.called

%Then CBS.R scrpt
