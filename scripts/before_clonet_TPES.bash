% Before clonet 
gatk3 -T ASEReadCounter -R ../Annotations/human_g1k_v37.fasta -o Normal.csv -I Control.sorted.realigned.recalibrated.bam -sites Control.het.vcf -U ALLOW_N_CIGAR_READS -minDepth 20 --minMappingQuality 20 --minBaseQuality 20
gatk3 -T ASEReadCounter -R ../Annotations/human_g1k_v37.fasta -o Tumor.csv -I Tumor.sorted.realigned.recalibrated.bam -sites Control.het.vcf -U ALLOW_N_CIGAR_READS -minDepth 20 --minMappingQuality 20 --minBaseQuality 20

% Before TPES
varscan somatic Control.pileup Tumor.pileup --output-snp somatic.pm --output-indel somatic.indel
 
 
