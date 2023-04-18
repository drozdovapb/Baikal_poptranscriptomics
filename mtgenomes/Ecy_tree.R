library(ggtree)


Ecytree <- read.tree("concat15genes24samples.aln.fa.treefile")

tiplabcols <- rep("black", length(Ecytree$tip.label))
tiplabcols[grep("EcyPB", Ecytree$tip.label)] <- "#4477AA"
tiplabcols[grep("EcySR", Ecytree$tip.label)] <- "#4477AA"
tiplabcols[grep("EcyBK", Ecytree$tip.label)] <- "#DDCC77"

ggtree(Ecytree) + 
  geom_tiplab(color = tiplabcols) + 
#  geom_nodelab() + 
  xlim(0,2) + 
  geom_treescale()

ggsave("Ecy_tree.png", width = 8, height = 6)
