## Here's an example for E. verrucosus

export seq2014=/media/tertiary/transcriptome_clean/old_trimmed_clean_corrected/

for file in $seq2014/Sample_Eve*1.*1.gz_val_1.cor.fq.gz; do base=$(basename $file ".1.gz_val_1.cor.fq.gz"); /media/secondary/apps/trinityrnaseq-v2.10.0/Trinity --seqType fq --max_memory 30G --left $seq2014/$base.1.gz_val_1.cor.fq.gz  --right $seq2014/$base.2.gz_val_2.cor.fq.gz --CPU 6  --SS_lib_type FR --output ${base}_cor_trinity_fr/; done

export seq2020=/media/tertiary/transcriptome_clean/NEB_trimmed_clean_corrected/
 for file in $seq2020/Eve*30-09*R1_val_1.cor.fq.gz; do base=$(basename $file "_R1_val_1.cor.fq.gz"); /media/secondary/apps/trinityrnaseq-v2.10.0/Trinity --seqType fq --max_memory 30G --left $seq2020/${base}_R1_val_1.cor.fq.gz  --right $seq2020/${base}_R2_val_2.cor.fq.gz --CPU 6  --SS_lib_type RF --output ${base}_cor_trinity_rf/; done