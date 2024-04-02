# Species tree from orthologs


## Species tree from BUSCO

let's try with assemblies with >55% BUSCO completeness
```
EcyBK_4_6orange_rnaspades_rf.fasta.busco5			C:71.6%[S:57.3%,D:14.3%],F:12.2%,M:16.2%,n:1013
EcyBK_4rest_rnaspades_rf.fasta.busco5			C:82.7%[S:64.5%,D:18.2%],F:9.4%,M:7.9%,n:1013
EcyBK_B24_12_rnaspades_fr.fasta.busco5			C:55.4%[S:46.8%,D:8.6%],F:22.1%,M:22.5%,n:1013
Ecy_Naumenko_rnaspades.fasta.busco5				C:70.9%[S:57.7%,D:13.2%],F:10.7%,M:18.4%,n:1013
EcyPB_10_rnaspades_rf.fasta.busco5				C:74.9%[S:50.0%,D:24.9%],F:12.3%,M:12.8%,n:1013
EcyPB_2_rnaspades_rf.fasta.busco5				C:89.3%[S:41.3%,D:48.0%],F:6.0%,M:4.7%,n:1013
EcyPB_3_rnaspades_rf.fasta.busco5				C:65.8%[S:44.8%,D:21.0%],F:15.0%,M:19.2%,n:1013
Eulimnogammarus_testaceus_rnaspades.fasta.busco5		C:74.7%[S:64.0%,D:10.7%],F:10.7%,M:14.6%,n:1013
EveBK_1_1_rnaspades_rf.fasta.busco5				C:87.4%[S:60.0%,D:27.4%],F:6.9%,M:5.7%,n:1013
Eve_Naumenko_rnaspades.fasta.busco5				C:80.4%[S:64.0%,D:16.4%],F:9.5%,M:10.1%,n:1013
EvePB_2_rnaspades_rf.fasta.busco5				C:81.9%[S:68.3%,D:13.6%],F:7.8%,M:10.3%,n:1013
EvePB_4_rnaspades_rf.fasta.busco5				C:70.4%[S:59.0%,D:11.4%],F:12.2%,M:17.4%,n:1013
EvePB_female_1_rnaspades_rf.fasta.busco5			C:79.0%[S:64.1%,D:14.9%],F:10.7%,M:10.3%,n:1013
EvePB_male_rnaspades_rf.fasta.busco5				C:80.4%[S:51.6%,D:28.8%],F:8.9%,M:10.7%,n:1013
EveBK_B24_123_cor_rnaspades_fr.fasta.busco5			C:64.1%[S:53.1%,D:11.0%],F:19.4%,M:16.5%,n:1013
``` 

```
mkdir busco5_3344; cd busco5_3344/
cp -r ../busco52/EcyBK_4_6orange_rnaspades_rf.fasta.busco5/ . ; cp -r ../busco52/EcyBK_4rest_rnaspades_rf.fasta.busco5 .
cp -r ../busco52/EcyBK_B24_12_rnaspades_fr.fasta.busco5 .
cp -r ../busco52/Ecy_Naumenko_rnaspades.fasta.busco5/ .
cp -r ../busco52/EcyPB*busco5/ .
cp -r ../busco52/Eulimnogammarus_testaceus_rnaspades.fasta.busco5 .
cp -r ../busco52/EveBK_1_1_rnaspades_rf.fasta.busco5 .
cp -r ../busco52/Eve_Naumenko_rnaspades.fasta.busco5/ .
cp -r ../busco52/EvePB_2_rnaspades_rf.fasta.busco5/ . ; cp -r ../busco52/EvePB_4_rnaspades_rf.fasta.busco5/ .
cp -r ../busco52/EvePB_female_1_rnaspades_rf.fasta.busco5/ .; cp -r ../busco52/EvePB_male_rnaspades_rf.fasta.busco5/ .
mv EveBK_B24_123_cor_rnaspades_fr.fasta.busco5/ busco52
cd busco5_3344/
cp -r ../busco52/EveBK_B24_123_cor_rnaspades_fr.fasta.busco5/ .
```

```
export PATH=$PATH:/media/secondary/apps/trimal/source/
https://github.com/rcedgar/muscle/releases/download/5.1.0/muscle5.1.linux_intel64
alias muscle="/media/secondary/apps/muscle5.1.linux_intel64"
```

BUSCO5 finally works after conda-assisted installation!

```python3 /media/secondary/apps/BUSCO_phylogenomics/BUSCO_phylogenomics.py -i ~/poptranscr/assemblies/busco5_3344/ -o ~/poptranscr/assemblies/busco5_3344/buscophylo/ --gene_tree_program iqtree -t 8```

Identified 33 BUSCO proteins that are complete and single-copy in all species:
153232at6656,40213at6656,110787at6656,43236at6656,143154at6656,104410at6656,163670at6656,135702at6656,13934at6656,113641at6656,55932at6656,165207at6656,120445at6656,156882at6656,98948at6656,99204at6656,43045at6656,151642at6656,159542at6656,117742at6656,160705at6656,92854at6656,126442at6656,166479at6656,129902at6656,90822at6656,108162at6656,101761at6656,159420at6656,87910at6656,26734at6656,126074at6656,112556at6656

```
10-04-2023 06:27:34	Identified 827 BUSCO proteins that are complete and single-copy in at least 4 species:
10-04-2023 06:27:34	Writing protein sequences to /media/main/sandbox/drozdovapb/poptranscr/assemblies/busco5_3344/buscophylo/gene_trees/proteins_4
10-04-2023 06:27:34	Aligning protein sequences using MUSCLE with 8 parallel jobs to: /media/main/sandbox/drozdovapb/poptranscr/assemblies/busco5_3344/buscophylo/gene_trees_single_copy/alignments_4
10-04-2023 06:30:31	Trimming alignments using trimAL (-automated1) with 8 parallel jobs to: /media/main/sandbox/drozdovapb/poptranscr/assemblies/busco5_3344/buscophylo/gene_trees_single_copy/trimmed_alignments_4
10-04-2023 06:30:31	Generating gene trees using iqtree with 8 parallel jobs to: /media/main/sandbox/drozdovapb/poptranscr/assemblies/busco5_3344/buscophylo/gene_trees_single_copy/trees_4
10-04-2023 06:42:39	Concatenating all 827 gene trees to: /media/main/sandbox/drozdovapb/poptranscr/assemblies/busco5_3344/buscophylo/gene_trees_single_copy/ALL.tree
10-04-2023 06:42:39	Done
```

It makes a supermatrix but doesn't build a tree based on it

ALL.tree contains 827 trees. *#todo* how can I build the supertree if not all trees contain not all taxa?

No problem, this I can do myself =)

```
iqtree -s SUPERMATRIX.fasta -p SUPERMATRIX.partitions.nex -alrt 1000 -abayes -o Eulimnogammarus_testaceus_rnaspades.fasta.busco5 --prefix supermatrix3344```

33 single-copy BUSCOs
							   +--EvePB_2_rnaspades_rf.fasta.busco5
							+--| (74.2/0.988)
							|  +--EvePB_female_1_rnaspades_rf.fasta.busco5
						 +--| (36.7/0.884)
						 |  +--EvePB_male_rnaspades_rf.fasta.busco5
					+----| (100/1)
					|    +--EvePB_4_rnaspades_rf.fasta.busco5
+-------------------| (100/1)
|                   |     +--EveBK_1_1_rnaspades_rf.fasta.busco5
|                   +-----| (99.9/1)
|                         |  +--Eve_Naumenko_rnaspades.fasta.busco5
|                         +--| (3.6/0.576)
|                            +--EveBK_B24_123_cor_rnaspades_fr.fasta.busco5
|
|                 +--EcyBK_4_6orange_rnaspades_rf.fasta.busco5
|              +--| (48.7/0.97)
|              |  |  +--EcyBK_B24_12_rnaspades_fr.fasta.busco5
|              |  +--| (68.7/0.893)
|              |     +--EcyBK_4rest_rnaspades_rf.fasta.busco5
|           +--| (80/0.998)
|           |  +--Ecy_Naumenko_rnaspades.fasta.busco5
+-----------| (100/1)
|           |  +----------------------------------------------EcyPB_2_rnaspades_rf.fasta.busco5
|           +--| (43.5/0.825)
|              |  +--EcyPB_10_rnaspades_rf.fasta.busco5
|              +--| (86.9/1)
|                 +--EcyPB_3_rnaspades_rf.fasta.busco5
|
+-----------Eulimnogammarus_testaceus_rnaspades.fasta.busco5
```


## Species (supermatrix) tree from all SCO

```
export TransDecoderDir=/media/secondary/apps/TransDecoder-TransDecoder-v5.7.0/
cd /media/main/sandbox/drozdovapb/poptranscr/Species_tree/transdecoder_570

export assembly=../../assemblies/EveBK_B24_123_cor_rnaspades_fr.fasta
$TransDecoderDir/TransDecoder.LongOrfs -t $assembly; $TransDecoderDir/TransDecoder.Predict -t $assembly --single_best_only
export proteome=EveBK_B24_123_cor_rnaspades_fr.fasta.transdecoder.pep
$appdir/cd-hit-v4.8.1-2019-0228/cd-hit -i $proteome -o cdhit_aa/$proteome.repr.faa


export assembly=../../assemblies/EcyBK_B24_12_rnaspades_fr.fasta
$TransDecoderDir/TransDecoder.LongOrfs -t $assembly; $TransDecoderDir/TransDecoder.Predict -t $assembly --single_best_only

export proteome=EcyBK_B24_12_rnaspades_fr.fasta.transdecoder.pep
$appdir/cd-hit-v4.8.1-2019-0228/cd-hit -i $proteome -o cdhit_aa/$proteome.repr.faa


## that's proteinortho 6.0.33 and diamond (it's external!!!) 2.0.14
proteinortho -project=EcyEveEte_3344 -cpus=9 cdhit_aa/EcyBK_4_6orange_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EcyBK_4rest_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EcyBK_B24_12_rnaspades_fr.fasta.transdecoder.pep.repr.faa cdhit_aa/EcyPB_10_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EcyPB_3_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EcyPB_2_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/Ecy_Naumenko_rnaspades.fasta.transdecoder.pep.repr.faa cdhit_aa/Eulimnogammarus_testaceus_rnaspades.fasta.transdecoder.pep.repr.faa cdhit_aa/EveBK_1_1_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EveBK_B24_123_cor_rnaspades_fr.fasta.transdecoder.pep.repr.faa cdhit_aa/Eve_Naumenko_rnaspades.fasta.transdecoder.pep.repr.faa cdhit_aa/EvePB_2_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EvePB_4_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EvePB_female_1_rnaspades_rf.fasta.transdecoder.pep.repr.faa cdhit_aa/EvePB_male_rnaspades_rf.fasta.transdecoder.pep.repr.faa



grep -v  \* EcyEveEte_3344.proteinortho.tsv  | grep -v -c "," 
2477... not bad!
Wow! Finally!!!

#todo

Now extract names (it's not stupid if it works)
grep -v  \* EcyEveEte_3344.proteinortho.tsv  | grep -v "," >  EcyEveEte_3344.proteinortho.onecopy.tsv
```

```{r}
options(stringsAsFactors = F) ##it's now default but still...
## read the filtered proteinortho table
onetoone <- read.delim("EcyEveEte_3344.proteinortho.onecopy.tsv") #, na.strings = "*")
		
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

```
mv families_tree/ oto_nucl3344/
cd /oto_nucl3344
pwd
/media/main/sandbox/drozdovapb/poptranscr/Species_tree/transdecoder_570/oto_nucl3344


### ??? ###for file in *cds; do xargs faidx $file < $(basename $file ".cds").pep.repr.faa.names.txt | fasta_formatter >./oto_nucl3344/$file.oto.fa ; done
cat *oto.fa >all.fasta

cd families_tree
## and now extract for each protein group one-by-one
for names in family*names.txt; do xargs faidx ../all.fasta < $names > $names.fasta ; done


## align each protein group
for multifasta in family*fasta; do mafft --auto $multifasta >$multifasta.aln; done

##trim alignment and make it single-line
export appdir=/media/secondary/apps
for alignment in *fasta.aln; do $appdir/trimal/source/trimal -automated1 -in $alignment -out $alignment.trim.aln; done
for tralignment in *trim.aln; do seqkit seq -w 0 $tralignment > $tralignment.sl.aln; done

##rename each sequence for concatenation
mkdir renamed_algns/
for file in *sl.aln; do seqkit replace -p ".*" -r '{nr}' --line-width 0 $file >./renamed_algns/$file.nums.aln; done

nano species.tbl
cd renamed_algns
for file in *nums.aln; do seqkit replace -p "(.*)" -r '{kv}' --kv-file ../../species.tbl $file >$file.renamed.aln; done 
rm *nums.aln

for file in *; do export basenm=$(basename $file ".names.txt.fasta.aln.trim.aln.sl.aln.nums.aln.renamed.aln"); mv $file $basenm.fa.aln; done
cd ../

pwd
/media/main/sandbox/drozdovapb/poptranscr/Species_tree/transdecoder_570/oto_nucl3344/families_tree

iqtree2 -p renamed_algns/ -abayes -pre renamed_families_tree_concat -nt 9 -alrt 1000 -bb 1000 -o Eulimnogammarus_testaceus --redo
```
![SCO_tree](https://github.com/drozdovapb/Baikal_poptranscriptomics/new/master/SCO_tree/pasted_image.png)
