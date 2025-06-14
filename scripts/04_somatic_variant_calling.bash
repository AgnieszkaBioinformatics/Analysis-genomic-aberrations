#Somatic Variant Calling (SNVs/indels):
gatk3 -T UnifiedGenotyper -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.realigned.recalibrated.dedup.bam -o Control.GATK.vcf -L ../Captured_Regions.bed
vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Control.GATK.vcf --out Control.GATK --recode --recode-INFO-all
gatk3 -T UnifiedGenotyper -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.recalibrated.dedup.bam -o Tumor.GATK.vcf -L ../Captured_Regions.bed
vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Tumor.GATK.vcf --out Tumor.GATK --recode --recode-INFO-all

