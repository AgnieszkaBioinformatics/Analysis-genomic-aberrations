# Annotating the variants with snpEff and snpSift on the control sample
snpEff -v hg19kg ./out_variant_calling/Control.GATK.recode.vcf -s ./out_variant_annotation/Control.GATK.recode.ann.html > ./out_variant_annotation/control.gatk.recode.ann.vcf

snpSift Annotate ./data/annotations/hapmap_3.3.b37.vcf ./out_variant_annotation/control.gatk.recode.ann.vcf > ./out_variant_annotation/control.gatk.recode.ann2.vcf

snpSift Annotate ./data/annotations/clinvar_Pathogenic.vcf ./out_variant_annotation/control.gatk.recode.ann2.vcf > ./out_variant_annotation/control.gatk.recode.ann3.vcf

# Annotating the variants with snpEff and snpSift on the tumor sample
snpEff -v hg19kg ./out_variant_calling/Tumor.GATK.recode.vcf -s ./out_variant_annotation/Tumor.GATK.recode.ann.html > ./out_variant_annotation/Tumor.GATK.recode.ann.vcf

snpSift Annotate ./data/annotations/hapmap_3.3.b37.vcf ./out_variant_annotation/Tumor.GATK.recode.ann.vcf > ./out_variant_annotation/Tumor.GATK.recode.ann2.vcf

snpSift Annotate ./data/annotations/clinvar_Pathogenic.vcf ./out_variant_annotation/Tumor.GATK.recode.ann2.vcf > ./out_variant_annotation/Tumor.GATK.recode.ann3.vcf

# Filtering the annotated variants for high impact and depth of coverage
cat ./out_variant_annotation/Control.GATK.recode.ann3.vcf | snpSift filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)"
cat ./out_variant_annotation/Tumor.GATK.recode.ann3.vcf | snpSift filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)"

# Taking only the heterozygous SNPs 
grep -E "(^#|0/1)" ./out_variant_calling/Control.GATK.recode.vcf > ./out_variant_calling/Control.het.vcf
grep -E "(^#|0/1)" ./out_variant_calling/Tumor.GATK.recode.vcf > ./out_variant_calling/Tumor.het.vcf

# filter for high confidence somatic events
cat ./out_variant_annotation/Tumor.GATK.recode.ann3.vcf | snpSift filter "(ANN[ANY].IMPACT = 'HIGH') & (DP > 20) & (exists ID)" > ./out_variant_annotation/Tumor.somatic.highimpact.vcf

# extract relevant information to create a table
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t[%ANN]\t%ID\t%DP\n' ./out_variant_annotation/Tumor.somatic.highimpact.vcf > somatic_events_table.tsv
