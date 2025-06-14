# Generate mpileup for control and tumor samples
samtools mpileup -q 1 -f ./data/annotations/human_g1k_v37.fasta \
  ./out_duplicates_removal/Control.sorted.realigned.recalibrated.dedup.bam \
  ./out_duplicates_removal/Tumor.sorted.realigned.recalibrated.dedup.bam \
  | varscan copynumber --output-file ./out_scnv/scna --mpileup 1

# segment the copy number data assigning number states (gain/loss/normal) to genomic regions
varscan copyCaller ./out_scnv/scna.copynumber \
  --output-file ./out_scnv/scna.copynumber.calledsegments
