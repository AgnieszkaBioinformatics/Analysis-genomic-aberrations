gatk3 -T RealignerTargetCreator -R ../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -o realigner.intervals -L DNA_Repair_Genes.bed
