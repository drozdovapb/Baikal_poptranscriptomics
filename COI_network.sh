## get all Eve data (consensus sequences from transcriptome + Anton's sequences from BMC
cat seqs/Eve/* >allEve.fa
sed -e 's/-g' allEve.fa | sed -e 's/\.g' >allEve.fixnames.fa
## align and trim
mafft --auto allEve.fixnames.fa >allEve.aln   ##FFT-NS-i (Standard)
~/lib/trimAl/source/trimal -in allEve.aln -out allEve.trim.aln -automated1 # automated1 is for ML
sed -e 's/ /_/g' allEve.trim.aln > allEve.trim.fixspaces.aln 
## then open with splitstree and save as nex.
~/lib/splitstree4/SplitsTree
## the .nex file can be loaded into R for custom visualization
