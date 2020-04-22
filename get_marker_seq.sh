#!/bin/bash
while getopts f:r:g:n:p option
do
case "${option}"
in
f) forward=${OPTARG};; #R1 reads
r) reverse=${OPTARG};; #R2 reads
g) reference=${OPTARG};; #reference marker gene sequence (eg COI)
n) name=${OPTARG};; #sample name, can be automatically extracted with basename
p) processors=${OPTARG};; #number of threads
esac
done

#build reference
bowtie2-build $reference $reference
#align reads to reference
bowtie2 -x $reference -1 $forward -2 $reverse --no-unal --very-sensitive-local -S $name.sam 
#some formatting (sam => sorted bam)
samtools view -Sb $name.sam >$name.bam
samtools sort -o ${name}_sorted.bam $name.bam 
#get variants
bcftools mpileup -f $reference ${name}_sorted.bam | bcftools call -c --ploidy 1 >$name.vcf
vcfutils.pl vcf2fq $name.vcf > $name.fastq
#fastq to fasta
seqtk seq -aQ64 -q5 -n N $name.fastq > $name.fasta
#fix fasta header
awk '/^>/ {gsub(/.fa(sta)?$/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $name.fasta  >$name.fixed.fasta
echo "$name done!"
