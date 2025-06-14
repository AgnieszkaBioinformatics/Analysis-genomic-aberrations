#Somatic Variant Calling (SNVs/indels):
gatk3 -T UnifiedGenotyper -R ../../Annotations/human_g1k_v37.fasta -I Control.sorted.realigned.recalibrated.dedup.bam -o Control.GATK.vcf -L ../Captured_Regions.bed
vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Control.GATK.vcf --out Control.GATK --recode --recode-INFO-all
gatk3 -T UnifiedGenotyper -R ../../Annotations/human_g1k_v37.fasta -I Tumor.sorted.realigned.recalibrated.dedup.bam -o Tumor.GATK.vcf -L ../Captured_Regions.bed
vcftools --minQ 20 --max-meanDP 200 --min-meanDP 5 --remove-indels --vcf Tumor.GATK.vcf --out Tumor.GATK --recode --recode-INFO-all

# Annotating the variants with snpEff and snpSift on the control sample
snpEff -Xmx4g -v hg19kg Control.GATK.recode.vcf -s Control.GATK.recode.ann.html > Control.GATK.recode.ann.vcf
snpsift annotate ../../Annotations/hapmap_3.3.b37.vcf Control.GATK.recode.ann.vcf > Control.GATK.recode.ann2.vcf
snpsift annotate ../../Annotations/clinvar_Pathogenic.vcf Control.GATK.recode.ann2.vcf > Control.GATK.recode.ann3.vcf

# Annotating the variants with snpEff and snpSift on the tumor sample
snpEff -Xmx4g -v hg19kg Tumor.GATK.recode.vcf -s Tumor.GATK.recode.ann.html > Tumor.GATK.recode.ann.vcf
snpsift annotate ../../Annotations/hapmap_3.3.b37.vcf Tumor.GATK.recode.ann.vcf > Tumor.GATK.recode.ann2.vcf
snpsift annotate ../../Annotations/clinvar_Pathogenic.vcf Tumor.GATK.recode.ann2.vcf > Tumor.GATK.recode.ann3.vcf

# Filtering the annotated variants for high impact and depth of coverage
cat Control.GATK.recode.ann3.vcf | snpsift filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)"
cat Tumor.GATK.recode.ann3.vcf | snpsift filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)"

# taking only heterozygous snps
grep -E "(^#|0/1)" Control.GATK.vcf > Control.het.vcf
grep -E "(^#|0/1)" Tumor.GATK.vcf > Tumor.het.vcf
