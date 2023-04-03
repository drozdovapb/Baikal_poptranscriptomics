## run BUSCO 5
## in the folder with assemblies
for file in *fasta; do busco -i $file -o $file.busco5 --cpu 8 --mode tran --lineage busco5/arthropoda_odb10/ --offline -f; done