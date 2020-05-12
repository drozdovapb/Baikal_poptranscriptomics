##todo: add samples list!
##remember: added 2 Naumenko sequences but removed EvePB_30_09 (repeatedly failed chi-square composition + only 7900 proteins predicted)

for assembly in ../*fasta; do /media/secondary/apps/TransDecoder-5.0.1/TransDecoder.LongOrfs -t $assembly -S; /media/secondary/apps/TransDecoder-5.0.1/TransDecoder.Predict -t $assembly --single_best_only; done

CD-hit!

cd /media/main/sandbox/drozdovapb/poptranscr/assemblies/transdecoder
mkdir cdhit_aa
for proteome in *pep; do $appdir/cd-hit-v4.8.1-2019-0228/cd-hit -i $proteome -o cdhit_aa/$proteome.repr.faa; done

##oops! Naumenko unstranded!
for assembly in ../*Naumenko*fasta; do /media/secondary/apps/TransDecoder-5.0.1/TransDecoder.LongOrfs -t $assembly; /media/secondary/apps/TransDecoder-5.0.1/TransDecoder.Predict -t $assembly --single_best_only; done

for proteome in *Naumenko*pep; do $appdir/cd-hit-v4.8.1-2019-0228/cd-hit -i $proteome -o cdhit_aa/$proteome.repr.faa; done

## remove
drozdovapb@proteomics-asus:/media/main/sandbox/drozdovapb/poptranscr/assemblies/transdecoder/$ mv EvePB_30_09_1_rnaspades_rf.fasta.transdecoder.* unused/
drozdovapb@proteomics-asus:/media/main/sandbox/drozdovapb/poptranscr/assemblies/transdecoder/cdhit_aa$ mv EvePB_30_09_1_rnaspades_rf.fasta.transdecoder.pep.repr.faa* unused/


## first, a common set of one-copy orthologs in all. Hope it works (more or less)
perl /media/secondary/apps/proteinortho_v6.0b/proteinortho6.pl -project=Eve_Ecy_proteinortho -cpus=9 cdhit_aa/Eve*repr.faa cdhit_aa/Ecy*repr.faa

#stopped_here

			```{r}
			options(stringsAsFactors = F)
		
			## read the proteinortho table
			tbl <- read.delim("../Eve_Ecy_proteinortho.proteinortho", na.strings = "*")
					
			## one-to-one orthologs for the tree!
			## present in each species
			presentinall <- tbl[complete.cases(tbl), ]
			## present in each species only once ##in this case it's each sample
			onetoone <- presentinall[presentinall$X..Species == presentinall$Genes, ]
					## write name lists to later extract
			for (i in 4:ncol(onetoone)) {
			writeLines(onetoone[,i], paste0(names(onetoone[i]), ".names.txt"))
			}
			dir.create("families_tree")		
			## and gene lists grouped by families
			for (i in 1:nrow(onetoone)) {
			oo <- as.matrix(onetoone)
			writeLines(oo[i, 4:ncol(onetoone)], paste0("families_tree/family", as.character(i), ".names.txt"))
			}
			```
			## 405 families! Good!

cd ../ ##transdecoder

## now extract the sequences from all fasta files (by species so far)
for file in *cds; do xargs faidx $file < Eve_Ecy_oto/$(basename $file ".cds").pep.repr.faa.names.txt | fasta_formatter >Eve_Ecy_oto/$file.oto.fa ; done

cd Eve_Ecy_oto/
cat *oto.fa >all.fasta
## and now extract for each protein group one-by-one
##../cdhit_aa/aa_families_tree/family*names.txt
for names in families_tree/family*names.txt; do xargs faidx all.fasta < $names > $names.fasta ; done

cd families_tree
## align each protein group
for multifasta in family*fasta; do mafft --auto $multifasta >$multifasta.aln; done

##trim alignment and make it single-line
for alignment in *fasta.aln; do $appdir/trimal/source/trimal -automated1 -in $alignment -out $alignment.trim.aln; done
for tralignment in *trim.aln; do seqkit seq -w 0 $tralignment > $tralignment.sl.aln; done

##concatenate...
##rename each sequence
for file in *sl.aln; do seqkit replace -p ".*" -r '{nr}' --line-width 0 $file >$file.nums.aln; done
seqkit concat *sl.aln.nums.aln >all_concat.aln

faSize -detailed all_concat.aln

nano species.tbl

seqkit replace -p "(.*)" -r '{kv}' --kv-file species.tbl all_concat.aln >all_concat_species.aln

## finally build the tree! 
$appdir/iqtree-1.6.10-Linux/bin/iqtree -s all_concat_species.aln -abayes -pre all_concat_species_sorted -nt 9 -alrt 1000
