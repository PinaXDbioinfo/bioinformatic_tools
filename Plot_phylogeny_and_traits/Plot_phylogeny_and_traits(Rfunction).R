plot_phylo_trait<-function(nexus_file,txt_file){

#necesary libraries
library(ape)


data <- data[match(tree$tip.label,data$V1),]
temp_colores<-colorspace::sequential_hcl(length(data$V2))
temp_data<-cbind(sort(data$V2,decreasing = T),colorspace::sequential_hcl(length(data$V2)))
colnames(temp_data)<-c("V1","V2")
temp_data<-as.data.frame(temp_data)
temp_data<-temp_data[match(data$V2,temp_data$V1),]

x_left   <- length(data$V1)*-0.0002347418
x_right  <- length(data$V1)*0.1173709
y_bottom <- length(data$V1)*0.004694836
y_top    <- length(data$V1)*0.04694836

pdf(tempfile())
plot(tree,show.tip.label = F,use.edge.length = F,adj = 0,underscore=F,root.edge=T,no.margin = T)
coords <- get("last_plot.phylo", envir = .PlotPhyloEnv)
dev.off()

png(paste0("tree_with_traits.png"),res = 1000,
    width = 208.3333*nchar(tree$tip.label[which.max(nchar(tree$tip.label))]),
    height = 164.3192*length(tree$tip.label),units = "px")
par(mar = c(5, 5, 4, (coords$x.lim[2]+15)))
plot(tree,show.tip.label = F,use.edge.length = F,adj = 0,edge.width = 2,underscore=F,
     edge.color = gray(0.30),root.edge=T,no.margin = T,x.lim = c(0, coords$x.lim[2]+150))
coords <- get("last_plot.phylo", envir = .PlotPhyloEnv)

for (j in 1:length(temp_colores)) {
  y0 <- y_bottom + (j-1)*(y_top - y_bottom)/length(temp_colores)
  y1 <- y_bottom + j*(y_top - y_bottom)/length(temp_colores)
  rect(x_left, y0, x_right, y1, col = rev(temp_colores)[j], border = NA,lwd = 1.5)
}
rect(x_left, y_bottom, x_right, y_top, border = "black")

text(x_right + 0.005, y_top, paste0(round(max(data$V2), 2)), adj = 0,font = 2,
     col = gray(0.25),cex = (0.00938967*2)*length(data$V2))
text(x_right + 0.005, y_bottom, paste0(round(min(data$V2), 2)), adj = 0,font = 2,
     col=gray(0.25),cex = (0.00938967*2)*length(data$V2))

points(rep(coords$x.lim[2], length(data$V2))-3.5, coords$yy[1:length(data$V2)], 
       pch = 21, bg = temp_data[,2], cex = 2)

for (j in 1:length(data$V2)) {
  text(rep(coords$x.lim[2], length(data$V2))-3.5,coords$yy[1:length(data$V2)][j], 
       labels = as.character(round(data$V2[j],digits = 1)), pos = 4, col = "black",cex = 0.8)
  text(rep(coords$x.lim[2], length(data$V2))-3.5,coords$yy[1:length(data$V2)][j], 
       labels = tree$tip.label[j], pos = 2, col = "black",cex = 0.9,adj = 0)
}
dev.off()
}
