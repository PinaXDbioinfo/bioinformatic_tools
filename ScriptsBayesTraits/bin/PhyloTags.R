library(ape)
library(diversitree)

args <- commandArgs(trailingOnly = TRUE)
nexus_file <- args[1]
tree<-read.nexus(paste0("../data/",nexus_file))

#estimate the number of internal nodes
n_internal <- tree$Nnode
n_total_tips <- length(tree$tip.label)
nodos_internos <- (n_total_tips + 1):(n_total_tips + n_internal)

#label the internal nodes with "Node1", "Node2", ...
tree$node.label <- paste0("Node", 1:n_internal)

#export a new phylogenetic tree labeled and a png of the phylogenetic tree with the internal nodes
write.tree(tree,file = "labeled_tree.nwk")

pdf(tempfile())
plot(tree,show.tip.label = F,use.edge.length = F,adj = 0,underscore=F,root.edge=T,no.margin = T)
coords <- get("last_plot.phylo", envir = .PlotPhyloEnv)
dev.off()
png(paste0("labeled_tree.png"),res = 1000,
    width = 208.3333*nchar(tree$tip.label[which.max(nchar(tree$tip.label))]),
    height = 16000,units = "px")
plot(tree,show.tip.label = T,use.edge.length = F,adj = 0,edge.width = 2,underscore=F,
     edge.color = gray(0.30),root.edge=T,no.margin = T,y.lim = c(1, coords$y.lim[2]),
     show.node.label = T,node.pos = 1,node.depth = 2)
dev.off()

#write a .txt with the descendants of each internal node
for (i in 1:length(tree$node.label)) {
  des_pos<-get.descendants(tree$node.label[i], tree, tips.only = T)
  des<-tree$tip.label[des_pos]
  write(paste(c(tree$node.label[i],des), collapse = " "), 
        file = paste0(tree$node.label[i],".txt"))
}

