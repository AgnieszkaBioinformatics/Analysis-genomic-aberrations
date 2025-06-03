gatk3 -T RealignerTargetCreator -R ../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -o realigner.intervals -L DNA_Repair_Genes.bed
gatk3 -T IndelRealigner -R ../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -targetIntervals realigner.intervals -o Control.sorted.realigned.bam -L DNA_Repair_Genes.bed
