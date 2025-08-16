suppressWarnings({#cargando librerias ncesarias
print("Loading necessary libraries")
library(ape)
  
  
args <- commandArgs(trailingOnly = TRUE)
data_name <- args[1]

#Loading data
print("Reading input files")
arbol<-read.tree("../../labeled_tree.nwk")
data<-read.csv(paste0("../../../data/",data_name),header = F,sep="\t")
descendants<-paste(c(read.csv(list.files(pattern = ".txt"),header = F,sep = " ")[1,2:length(read.csv(list.files(pattern = ".txt"),header = F,sep = " "))],collapse=" "))[1:length(paste(c(read.csv(list.files(pattern = ".txt"),header = F,sep = " ")[1,2:length(read.csv(list.files(pattern = ".txt"),header = F,sep = " "))],collapse=" ")))-1]
Node<-paste(read.csv(list.files(pattern = ".txt"),header = F,sep = " ")[1])

dataSorted<-c()
for (i in 1:length(arbol$tip.label)) {
  dataSorted<-c(dataSorted,data$V2[which(arbol$tip.label[i]==data$V1)])
}

#estimation of ML value
print(paste0("Obtaining ancestral value of: ",Node))
rec<-ace(dataSorted, arbol, type="continuous", method="ML",model = "BM", marginal = T)
descendants<-sort(descendants)
data<-data[order(data[,1]),]
descendants_values<-c()

for (i in 1:length(descendants)) {
  temp<-data[data$V1==descendants[i],]$V2
  descendants_values<-c(descendants_values,temp)
}

resultRec<-cbind(rec$ace[as.numeric(strsplit(Node,"Node")[[1]][2])],
                 rec$CI9[as.numeric(strsplit(Node,"Node")[[1]][2]),][1],
                 rec$CI9[as.numeric(strsplit(Node,"Node")[[1]][2]),][2],
                 min(descendants_values),
                 max(descendants_values),
                 (rec$CI9[as.numeric(strsplit(Node,"Node")[[1]][2]),][2]-rec$CI9[as.numeric(strsplit(Node,"Node")[[1]][2]),][1])/1.96)
colnames(resultRec)<-c("valorRec","IC_L","IC_U","min_value_trait","max_value_trait","SE")

#exportar resultado
write.csv(resultRec,"RecML.csv",row.names = F)
})

