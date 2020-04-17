#!/bin/bash
while getopts f:r:g:n:p option
do
case "${option}"
in
f) forward=${OPTARG};;
r) reverse=${OPTARG};;
g) reference=${OPTARG};;
n) name=${OPTARG};;
p) processors=${OPTARG};;
esac
done

bowtie2-build $reference $reference
bowtie2 -x $reference -1 $forward -2 $reverse --no-unal --very-sensitive-local -S $name.sam 
samtools view -Sb $name.sam >$name.bam
 samtools sort -o ${name}_sorted.bam $name.bam 
bcftools mpileup -f $reference $name.bam | bcftools call -c --ploidy 1 >$name.vcf
vcfutils.pl vcf2fq $name.vcf > $name.fastq
seqtk seq -aQ64 -q5 -n N $name.fastq > $name.fasta
awk '/^>/ {gsub(/.fa(sta)?$/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $name.fasta  >$name.fixed.fasta
