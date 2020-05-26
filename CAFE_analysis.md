# CAFE analysis

`cd /media/main/sandbox/drozdovapb/poptranscr/CAFE`
This time for Eve only. This is what we're mostly interested in, right?

Copy the files 
`cp ../assemblies/transdecoder/Eve_Ecy_proteinortho.proteinortho .`
`cp ../assemblies/transdecoder/Eve_oto/families_tree/all_concat_species_sorted.bionj .`

	## Getting and setting the app (CAFE)
	be careful: the github page (neither CAFE nor CAFExp) doesn't contain the src, so it can't be built.
	`cd $appdir`
	`wget https://github.com/hahnlab/CAFE/releases/download/v4.2.1/CAFE-4.2.1.tar.gz`
	`tar xf CAFE-4.2.1.tar.gz `
	`./configure`
	`make`
	`cd /media/main/sandbox/drozdovapb/poptranscr/CAFE`
`cp $appdir/CAFE/release/cafe .`

## CAFE inputs: table with the numbers of orthologs in groups and tree

		### Fix PO table
		```{r}
			options(stringsAsFactors = F)
			library(stringr)
			po <- read.delim("Eve_proteinortho.proteinortho")
			pom <- po[, 4:ncol(po)]
			#to matrix of counts
			po2 <- apply(X = pom, MARGIN = c(1,2), function(x) {str_count(x, ",")+1})
			#safety precaution
			po[, 4:ncol(po)] <- po2
			#we need 2 columns before the numbers
			po <- po[ , -1]
			str(po)
			#first column
			names(po)[1] <- "FAMILYDESC"
			po[ ,1] <- NA
			#second column
			names(po)[2] <- "FAMILY"
			po[2] <- 1:nrow(po)
			po3 <- po
			names(po3) <- sapply(names(po), function(x) {gsub("_rnaspades.*.fasta.transdecoder.pep.repr.faa", "", x)})
			write.table(x=po3, file="Eve_proteinortho.proteinortho.cafe", sep="\t", quote = FALSE, row.names=F)
		```
		
		Needs more fixing: 
		First, underscores are not allowed (didn't find anywhere in the manual!?)
		`sed -e 's/_//g' Eve_proteinortho.proteinortho.cafe >Eve_proteinortho.nounderscore.proteinortho.cafe`
		Second, I removed one sample from the tree, so also needed to remove it from here.
		it's #13. Funny!
		`cut -f 1-12,14-27  Eve_proteinortho.nounderscore.proteinortho.cafe >Eve_proteinortho.nounderscore.noPB1.proteinortho.cafe`
		
		

		### Fix the tree
		cat all_concat_species_sorted.bionj 
		"((EveBK_B3_2:0.00008771,EveBK_B3_1:0.00008734):0.00000558,((EveBK_B3_4:0.00007442,EveBK_B3_3:0.00007574):0.00000812,EveBK_B24_1:0.00008362):0.00000302,((((Eve_Naumenko:0.00047224,((((((EveUB_2018_9:0.00017291,EveUB_2018_3:0.00015021):0.00000714,EveUB_2018_2:0.00014072):0.00000931,(EveUB_2018_8:0.00015696,EveUB_2018_1:0.00017207):0.00001304):0.00001315,EveUB_2018_7:0.00017974):0.00010863,EcyBK_4rest:0.00083677):0.00001768,(EvePB_male:0.00018439,(EvePB_female_2:0.00014329,((EvePB_female_1:0.00014722,EvePB_7:0.00014266):0.00000095,(EvePB_4:0.00014736,(EvePB_30_09_2:0.00014561,EvePB_2:0.00012489):0.00000431):0.00001122):0.00000801):0.00001664):0.00010734):0.00004961):0.00001487,EveBK_B24_2:0.00011710):0.00001384,EveBK_1_1:0.00018353):0.00000573,EveBK_B24_3:0.00008249):0.00001261);"

		So, kept getting the 'tree must be binary'.
https://hahnlab.github.io/CAFE/src_docs/html/Tree.html: 
* should be ultrametric (all paths from root to tip should have the same length). 
* Please note that there should be no spaces in the tree string, 
* nor semicolons at the end of the line.
* ##example  (((chimp:6,human:6):81,(mouse:17,rat:17):70):6,dog:93)
		+ Google: it should be rooted! Otherwise, it keeps complaining about being ultrametric.
* They recommend `r8s` but I couldn't get it work. make fails.

		Make it ultrametric:
		python3.4
		>>> from ete3 import Tree
		>>> t = Tree("((EveBK_B3_2:0.00008771,EveBK_B3_1:0.00008734):0.00000558,((EveBK_B3_4:0.00007442,EveBK_B3_3:0.00007574):0.00000812,EveBK_B24_1:0.00008362):0.00000302,((((Eve_Naumenko:0.00047224,((((((EveUB_2018_9:0.00017291,EveUB_2018_3:0.00015021):0.00000714,EveUB_2018_2:0.00014072):0.00000931,(EveUB_2018_8:0.00015696,EveUB_2018_1:0.00017207):0.00001304):0.00001315,EveUB_2018_7:0.00017974):0.00010863,EcyBK_4rest:0.00083677):0.00001768,(EvePB_male:0.00018439,(EvePB_female_2:0.00014329,((EvePB_female_1:0.00014722,EvePB_7:0.00014266):0.00000095,(EvePB_4:0.00014736,(EvePB_30_09_2:0.00014561,EvePB_2:0.00012489):0.00000431):0.00001122):0.00000801):0.00001664):0.00010734):0.00004961):0.00001487,EveBK_B24_2:0.00011710):0.00001384,EveBK_1_1:0.00018353):0.00000573,EveBK_B24_3:0.00008249):0.00001261);")
		>>> t.set_outgroup("EcyBK_4rest")
		>>> t.convert_to_ultrametric()
		>>> print(t.write())
		(EcyBK_4rest:0.000957915,(((((EveUB_2018_9:0.000172425,EveUB_2018_3:0.000172425)1:0.000172425,EveUB_2018_2:0.000344849)1:0.000172425,(EveUB_2018_8:0.000258637,EveUB_2018_1:0.000258637)1:0.000258637)1:0.000172425,EveUB_2018_7:0.000689699)1:0.000172425,((EvePB_male:0.00063861,(EvePB_female_2:0.000510888,((EvePB_female_1:0.000191583,EvePB_7:0.000191583)1:0.000191583,(EvePB_4:0.000255444,(EvePB_30_09_2:0.000127722,EvePB_2:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722,(Eve_Naumenko:0.000670541,(EveBK_B24_2:0.000574749,(EveBK_1_1:0.000478958,(EveBK_B24_3:0.000383166,((EveBK_B3_2:0.000143687,EveBK_B3_1:0.000143687)1:0.000143687,((EveBK_B3_4:9.57915e-05,EveBK_B3_3:9.57915e-05)1:9.57915e-05,EveBK_B24_1:0.000191583)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05);
		
		Round: 
		```{r}
		library(ape)
		t <- read.tree(text = "(EcyBK_4rest:0.000957915,(((((EveUB_2018_9:0.000172425,EveUB_2018_3:0.000172425)1:0.000172425,EveUB_2018_2:0.000344849)1:0.000172425,(EveUB_2018_8:0.000258637,EveUB_2018_1:0.000258637)1:0.000258637)1:0.000172425,EveUB_2018_7:0.000689699)1:0.000172425,((EvePB_male:0.00063861,(EvePB_female_2:0.000510888,((EvePB_female_1:0.000191583,EvePB_7:0.000191583)1:0.000191583,(EvePB_4:0.000255444,(EvePB_30_09_2:0.000127722,EvePB_2:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722)1:0.000127722,(Eve_Naumenko:0.000670541,(EveBK_B24_2:0.000574749,(EveBK_1_1:0.000478958,(EveBK_B24_3:0.000383166,((EveBK_B3_2:0.000143687,EveBK_B3_1:0.000143687)1:0.000143687,((EveBK_B3_4:9.57915e-05,EveBK_B3_3:9.57915e-05)1:9.57915e-05,EveBK_B24_1:0.000191583)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05)1:9.57915e-05);")
		root(t, outgroup = "EcyBK_4rest")
		t$edge.length <- round(t$edge.length * 10^5)
		write.tree(t, "t.nwk")
		```
		Now it's not ultrametric. Great.
Manual: replaced ):1 with ): and removed the semicolon!
		
		now it's not ultrametric...
		Made it ultrametric again with python.

		Again round in R:
		```{r}
		t2 <- read.tree(text = "(EcyBK_4rest:100,(((((EveUB_2018_9:18,EveUB_2018_3:18)1:18,EveUB_2018_2:36)1:18,(EveUB_2018_8:27,EveUB_2018_1:27)1:27)1:18,EveUB_2018_7:72)1:18,((EvePB_male:66.6667,(EvePB_female_2:53.3333,((EvePB_female_1:20,EvePB_7:20)1:20,(EvePB_4:26.6667,(EvePB_30_09_2:13.3333,EvePB_2:13.3333)1:13.3333)1:13.3333)1:13.3333)1:13.3333)1:13.3333,(Eve_Naumenko:70,(EveBK_B24_2:60,(EveBK_1_1:50,(EveBK_B24_3:40,((EveBK_B3_2:15,EveBK_B3_1:15)1:15,((EveBK_B3_4:10,EveBK_B3_3:10)1:10,EveBK_B24_1:20)1:10)1:10)1:10)1:10)1:10)1:10)1:10)1:10);")
		t2$edge.length <- round(t2$edge.length * 3)
		write.tree(t2, "t2.nwk")
		```
		Underscores are also a problem (in fact, looks like they pose a greater problem in the tree than in the table, but anyways, the names need to coincide.
		So, removed them (text editor).

## Load into CAFE

./cafe
# load -i Eve_proteinortho.proteinortho.cafe
Family information: Eve_proteinortho.proteinortho.cafe
Log: stdout
The number of families is 92458
Root Family size : 1 ~ 30
Family size : 0 ~ 57
P-value: 0.01
Num of Threads: 1
Num of Random: 1000
# tree (EcyBK_4rest:900,(((((EveUB_2018_9:162,EveUB_2018_3:162)1:162,EveUB_2018_2:324)1:162,(EveUB_2018_8:243,EveUB_2018_1:243)1:243)1:162,EveUB_2018_7:648)1:162,((EvePB_male:600,(EvePB_female_2:480,((EvePB_female_1:180,EvePB_7:180)1:180,(EvePB_4:240,(EvePB_30_09_2:120,EvePB_2:120)1:120)1:120)1:120)1:120)1:120,(Eve_Naumenko:630,(EveBK_B24_2:540,(EveBK_1_1:450,(EveBK_B24_3:360,((EveBK_B3_2:135,EveBK_B3_1:135)1:135,((EveBK_B3_4:90,EveBK_B3_3:90)1:90,EveBK_B24_1:180)1:90)1:90)1:90)1:90)1:90)1:90)1:90)1:90)


`./cafe`
`# load -i Eve_proteinortho.nounderscore.noPB1.proteinortho.cafe `
Family information: Eve_proteinortho.nounderscore.proteinortho.cafe
Log: stdout
The number of families is 92458
Root Family size : 1 ~ 30
Family size : 0 ~ 57
P-value: 0.01
Num of Threads: 1
Num of Random: 1000
`# tree (EcyBK4rest:900,(((((EveUB20189:162,EveUB20183:162)1:162,EveUB20182:324)1:162,(EveUB20188:243,EveUB20181:243)1:243)1:162,EveUB20187:648)1:162,((EvePBmale:600,(EvePBfemale2:480,((EvePBfemale1:180,EvePB7:180)1:180,(EvePB4:240,(EvePB30092:120,EvePB2:120)1:120)1:120)1:120)1:120)1:120,(EveNaumenko:630,(EveBKB242:540,(EveBK11:450,(EveBKB243:360,((EveBKB32:135,EveBKB31:135)1:135,((EveBKB34:90,EveBKB33:90)1:90,EveBKB241:180)1:90)1:90)1:90)1:90)1:90)1:90)1:90)1:90)`
`# lambda -s`
Did some search... Tail of the output:
.Lambda : 0.00000269878819 & Score: -39955.067785
.Lambda : 0.00000269837673 & Score: -39955.067854
.Lambda : 0.00000269858246 & Score: -39955.067805
.Lambda : 0.00000269899392 & Score: -39955.067794
.Lambda : 0.00000269858246 & Score: -39955.067805
.Lambda : 0.00000269868533 & Score: -39955.067792
.Lambda : 0.00000269889106 & Score: -39955.067786
.
Lambda Search Result: 32
Lambda : 0.00000269878819 & Score: 39955.067785
DONE: Lambda Search or setting, for command:
lambda -s 
`# report resultfile`
Running Viterbi algorithm....
Report Done



## Further reading
* https://github.com/hahnlab/CAFE/blob/master/docs/cafe_manual.pdf CAFE manual
* http://phylobotanist.blogspot.com/2015/02/dated-phylogenies-my-experience-using.html about r8s
* https://hahnlab.github.io/CAFE/ CAFE main page
* https://github.com/LKremer/CAFE_fig: probably great but needs ETE3 version 3.0.0b35 and PyQT4, and I couldn't get it work.
* https://scholarworks.iu.edu/dspace/handle/2022/21899 A useful presentation about CAFE
* http://evomicsorg.wpengine.netdna-cdn.com/wp-content/uploads/2016/06/cafe_tutorial-1.pdf The wonderful CAFE tutorial
* https://iu.app.box.com/v/cafetutorial-files/folder/22161186238 all the files for the CAFE tutorial (including python scripts for analysis of the results). The scripts work with example data from CAFE_fig but not with my data...
Maybe 'cause it's a newer version???


Difference:
(eda_57:413,((rpr_32:357,((((hsa_29:133,(lhu_36:132,(cfl_25:111,(pba_40:95,(sin_30:79,(aec_27:11,ace_42:11)_33:68)_33:16)_33:16)_32:21)_32:1)_32:29,ame_25:162)_31:41,nvi_26:203)_31:122,((dme_22:272,aae_26:272)_27:38,tca_25:310)_29:15)_31:32)_32:1,((((mna_27:121,cse_29:121)_31:11,zne_32:132)_31:96,bge_43:228)_33:67,lmi_28:295)_32:63)_32:55)_34   0.000300        ((0.000228,0.383300),(0.880429,0.606508),(0.366361,0.574129),(0.163707,0.723983),(0.116645,0.244712),(0.012058,0.786919),(0.452908,0.907964),(0.033560,0.003391),(0.365525,0.062159),(0.874006,0.455112),(0.897236,0.257173),(0.235817,0.850931),(0.460085,0.224441),(0.728536,0.902521),(0.393979,0.690485),(0.834725,0.673933),(0.503599,0.017471),(0.558419,0.408871)) 
vs 
10      (EcyBK4rest_1:900,(((((EveUB20189_1:162,EveUB20183_1:162)1_1:162,EveUB20182_1:324)1_1:162,(EveUB20188_1:243,EveUB20181_1:243)1_1:243)1_1:162,EveUB20187_1:648)1_1:162,((EvePBmale_1:600,(EvePBfemale2_1:480,((EvePBfemale1_1:180,EvePB7_1:180)1_1:180,(EvePB4_1:240,(EvePB30092_1:120,EvePB2_1:120)1_1:120)1_1:120)1_1:120)1_1:120)1_1:120,(EveNaumenko_1:630,(EveBKB242_1:540,(EveBK11_1:450,(EveBKB243_1:360,((EveBKB32_1:135,EveBKB31_1:135)1_1:135,((EveBKB34_1:90,EveBKB33_1:90)1_1:90,EveBKB241_1:180)1_1:90)1_1:90)1_1:90)1_1:90)1_1:90)1_1:90)1_1:90)1_1:90)_1        0.527   ((-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-),(-,-))
