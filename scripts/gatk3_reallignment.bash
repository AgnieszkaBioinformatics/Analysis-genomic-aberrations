% Reallignment of control
gatk3 -T RealignerTargetCreator -R ../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -o realigner.intervals -L DNA_Repair_Genes.bed
gatk3 -T IndelRealigner -R ../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -targetIntervals realigner.intervals -o Control.sorted.realigned.bam -L DNA_Repair_Genes.bed

% Reallignment of tumor
gatk3 -T RealignerTargetCreator -R ../Annotations/human_g1k_v37.fasta -I Tumor.sorted.bam -o realigner.intervals -L DNA_Repair_Genes.bed
gatk3 -T IndelRealigner -R ../Annotations/human_g1k_v37.fasta -I Tumor.sorted.bam -targetIntervals realigner.intervals -o Tumor.sorted.realigned.bam -L DNA_Repair_Genes.bed
