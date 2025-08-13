
print("Loading libraries")
library(HDInterval)
library(coda)
library(posterior)

  
  args <- commandArgs(trailingOnly = TRUE)
  Log_data <- args[1]


  print(paste0("Reading file: ",Log_data))
  lines <- readLines(Log_data)
  temppos<-grep(pattern = "Iteration",lines)[2]
  lines<-lines[temppos:length(lines)]
  temp_file <- tempfile()
  writeLines(lines, temp_file)
  data <- read.table(temp_file, header = TRUE, sep = "\t")
  unlink(temp_file)
  data$X<-NULL
  rm(lines,temppos,temp_file)

  #GRAPH TRACEPLOT
  print(paste0("Ploting the traceplot of file: ",Log_data))
  colnames(data) <- make.names(colnames(data))
  tempmcmc<-mcmc(data)
  png(paste0(Log_data,"_traceplot.png"), width = 3000, height = 2100, res = 300)
  traceplot(tempmcmc,smooth = T,main =  paste0("Traceplot ",Log_data), cex.main = 2,
            cex.lab = 1.4, cex.axis = 1.6,col = "darkgreen", lwd=2.5, ylab = "Trait value")
  grid()
  dev.off()

  #NUMERIC SUMMARY OF THE RUN
  print(paste0("Runing postinferecial analyses of the file: ",Log_data))
  tempdata<-data[[length(colnames(data))]]
  print("Estimating HPDs")
  hpds<-hdi(tempdata, credMass = 0.95)[1:2]
  print("Estimating ESSs")
  temp_ESS<-effectiveSize(tempmcmc)[length(effectiveSize(tempmcmc))]
  essCola<-ess_tail(tempmcmc[,length(colnames(data))])
  essBulk<-ess_bulk(tempmcmc[,length(colnames(data))])
  print("Runing Heidelberger-weilch test")
  heidelberger<-heidel.diag(tempmcmc)[6,]
  print("Estimating the harmonic mean")
  armonic<-length(tempdata)/(sum(1/tempdata))
  print("Estimating the mode")
  modaRec<-density(tempdata)$x[which.max(density(tempdata)$y)]
  
  tempDF<-c(Log_data,hpds,temp_ESS,essBulk,essCola,heidelberger[3],mean(tempdata),armonic,
            modaRec)
  tempDF<-as.data.frame(t(tempDF))
  print("Exporting the results")
  colnames(tempDF)<-c("File","HPD_L","HPD_U","ESS","Central_ESS","Tail_ESS","pvalue_HW-test",
                            "arithmetic_mean","harmonic_mean","mode")
  write.csv(tempDF,file = paste0(Log_data,"_ReconstructionSummary.csv"),row.names = FALSE)

  #POSTERIOR DISTRIBUTION
  print("Ploting posterior distribution")
  png(paste0(Log_data,"_distribution.png"),width = 3000, height = 2100, res = 300)
  hist(tempdata, col = rgb(0, 0, 1, 0.2),border = "white",lwd = 2, cex.lab = 1.5, cex.axis = 1.5,
       xlab = "trait value",xlim = c(sort(tempdata)[1],sort(tempdata)[length(tempdata)]),
       prob = TRUE,breaks = 50,ylim = c(0,max(density(tempdata)$y)),xaxt="n",
       main=paste0("Posterior distribution of reconstructed trait file: ",Log_data),
       cex.main=1.5)
  lines(density(tempdata), col = "mediumblue", lwd = 2,, main = "",xlab = "trait_value")
  abline(v = mean(tempdata), col = "slategray", lwd = 3, lty = 2)
  abline(v = armonic,col = "slateblue4",lwd = 3,lty = 2)
  abline(v = modaRec, col = "purple",lwd = 3,lty = 2)
  legend("topright",legend = c(paste0("arithmetic mean: ",round(mean(tempdata),digits = 2)),
                               paste0("harmonic mean: ",round(armonic,digits = 2)),
                               paste0("mode: ",round(modaRec,digits = 2))), 
         col = c("slategray","slateblue4","purple"), cex = 0.85,pch = 16,bty ="o",y.intersp = 0.7,
         box.lwd = 0.5)
  axis(1, at = round(seq(min(tempdata), max(tempdata), by = max(tempdata)/15),digits = 2),
       cex=1.5,lwd = 2)
  grid()
  dev.off()



