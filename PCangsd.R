rm(list=ls()) #clears all variables
objects() # clear all objects
graphics.off() #close all figures
## set your working directory, e.g. setwd("~/")
setwd("/cerberus/projects/chrwhe/Pieris_napi_old_demography/bams/angsd_work/")

# following
# https://github.com/Rosemeis/pcangsd

library(RcppCNPy)

s<-strsplit(basename(scan("all.files",what="theFuck")),"\\.")
pop<-sapply(s,function(x)x[1])
pop3 <- c("Abisko","Abisko","Dalarna","Dalarna","Denmark","Gotland","Skane","Skane","Skane","Skane","Stockholm","Stockholm","Stockholm")

# data
C <- npyLoad("admix_nok.admix.Q.npy") # Reads in estimated covariance matrix
pop3 <- c("Abisko","Abisko","Dalarna","Dalarna","Denmark","Gotland","Skane","Skane","Skane","Skane","Stockholm","Stockholm","Stockholm")
# population level
pdf("PCA_plot.pdf", width = 10, height=7)
par(mfcol=c(2,1))
plot(C,lwd=2,ylab="PC 2",xlab="PC 1",main="Principal components",col=as.factor(pop3),pch=16);legend("top",fill=1:10,levels(as.factor(pop3)))
# individual samples
plot(C,lwd=2,ylab="PC 2",xlab="PC 1",main="Principal components",col=as.factor(pop),pch=(pop));legend("top",fill=1:13,levels(as.factor(pop)))
dev.off()

# admixture plots
q<-read.table("admix_nok.cov")
ord = order(pop)
par(mar=c(7,4,1,1))
pdf("Admixture_plot.pdf", width = 10, height=7)
par(mfcol=c(1,1))
barplot(t(C)[,ord],col=c(2,1,3),names=pop[ord],las=2,ylab="Admixture proportions",cex.names=0.75)
dev.off()

# Inbreeding coefficients (both per-individual and per-site)
# data, scales between -1 and 1
I <- npyLoad("inbreed_1.inbreed.npy") # Reads in estimated covariance matrix
# this is a different estimation method of inbreeding, scaling between 0 and 1
I2 <- npyLoad("inbreed_2.inbreed.npy") # Reads in estimated covariance matrix

pdf("Inbreeding_coefficient_plot.pdf", width = 10, height=7)
par(mfcol=c(1,1))
barplot(t(I2)[,ord],names=pop[ord],las=2,ylab="Inbreeding coefficient",cex.names=0.75,ylim = c(0, 0.1))
dev.off()
