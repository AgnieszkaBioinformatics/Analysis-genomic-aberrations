% Reallignment of control
gatk3 -T RealignerTargetCreator -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -o control.realigner.intervals -L ../Captured_Regions.bed
gatk3 -T IndelRealigner -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.bam -targetIntervals control.realigner.intervals -o Control.sorted.realigned.bam -L ../Captured_Regions.bed

% Reallignment of tumor
gatk3 -T RealignerTargetCreator -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.bam -o tumor.realigner.intervals -L ../Captured_Regions.bed
gatk3 -T IndelRealigner -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.bam -targetIntervals tumor.realigner.intervals -o Tumor.sorted.realigned.bam -L ../Captured_Regions.bed

% Recalibration of control
gatk3 -T BaseRecalibrator -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.realigned.bam -knownSites ../../Annotations/hapmap_3.3.b37.vcf -o recal.table -L ../Captured_Regions.bed
gatk3 -T PrintReads -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.realigned.bam -BQSR recal.table -o Control.sorted.realigned.recalibrated.bam -L ../Captured_Regions.bed --emit_original_quals
gatk3 -T BaseRecalibrator -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.realigned.recalibrated.bam -knownSites ../../Annotations/hapmap_3.3.b37.vcf -BQSR recal.table -o after_recal.table -L ../Captured_Regions.bed
gatk3 -T AnalyzeCovariates -R ../../Annotations/human_g1k_v37.fasta -before recal.table -after after_recal.table -csv recal.csv -plots Control_recal.pdf

% Recalibration of tumor
% Recalibration of control
gatk3 -T BaseRecalibrator -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.bam -knownSites ../../Annotations/hapmap_3.3.b37.vcf -o recal.table -L ../Captured_Regions.bed
gatk3 -T PrintReads -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.bam -BQSR recal.table -o Tumor.sorted.realigned.recalibrated.bam -L ../Captured_Regions.bed --emit_original_quals
gatk3 -T BaseRecalibrator -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.recalibrated.bam -knownSites ../../Annotations/hapmap_3.3.b37.vcf -BQSR recal.table -o after_recal.table -L ../Captured_Regions.bed
gatk3 -T AnalyzeCovariates -R ../../Annotations/human_g1k_v37.fasta -before recal.table -after after_recal.table -csv recal.csv -plots Control_recal.pdf

