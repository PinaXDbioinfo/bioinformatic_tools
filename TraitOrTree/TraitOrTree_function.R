TraitOrTree<-function(nexus_file,txt_file){
  library(ape)
  #check if exists NAs in the data
  if (length(which(is.na(txt_file[2])))==0) {
    nothing<-c()
  } else {txt_file<-txt_file[-c(which(is.na(txt_file[2])==TRUE)),]}
  #list species in the tree
  especiesarbol<-nexus_file$tip.label
  #filtering of wich species are not in the tree for delete in the data
  newdata<-c()
  for (i in 1:length(txt_file[1][[1]])) {
    if ((length(which(txt_file[1][[1]][i]==especiesarbol)))==1) {
      newdata<-rbind(newdata,txt_file[c(which(txt_file[1]==txt_file[1][[1]][i])),])
    } else {nothing<-c()}
  }
  #list of species for prune the tree
  especieParaPodar<-setdiff(especiesarbol,newdata[1][[1]])
  newArbol<-drop.tip(nexus_file,especieParaPodar)
  #write the new tree and data
  write.table(newdata,sep = "\t",col.names = F,row.names = F,file = "new_data.txt", quote = F)
  write.tree(newArbol,file = "new_tree.nwk")
}
