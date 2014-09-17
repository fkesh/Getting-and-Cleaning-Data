#setwd("C:/Users/Farhad/Documents/University/Coursera/Data Science  John Hopkins/2 - Getting and Cleaning Data/Homeworks")
#---------- load data
tefurl<-"./UCI HAR Dataset/test/X_test.txt"
trfurl<-"./UCI HAR Dataset/train/X_train.txt"
#tef<-read.csv(tefurl,header=FALSE)
#trf<-read.csv(trfurl,header=FALSE)
teDF<-read.table(tefurl, header=FALSE,  stringsAsFactors = FALSE, fill = TRUE)
trDF<-read.table(trfurl, header=FALSE,  stringsAsFactors = FALSE, fill = TRUE)
#---------- if the trf and tef have same length?
ltef<-ncol(teDF)
ltrf<-ncol(trDF)
#testDF<-teDF
#trainDF<-trDF
#Merge
mDF<-rbind(teDF,trDF)

#----------- Find columns of interest
ffurl<-"./UCI HAR Dataset/features.txt"
ff<-read.csv(ffurl,header=FALSE,sep=" ")
nrow(ff)
cn<- as.character(ff[,2])
names(mDF)<-cn
meanCols<-grep("mean()",ff[,"V2"])
stdCols<-grep("std()",ff[,"V2"])


#------- get meand and std rows
library(reshape)
aCols<-c(meanCols,stdCols)
aCols<-aCols[sort.list(aCols)]
msC<-as.numeric(aCols)
msDF<-mDF[,msC]
names(msDF)<-gsub("\\(\\)","",names(msDF))
names(msDF)<-gsub("[:alnum:]*-std[:alnum:]*","-standard deviation",names(msDF))
names(msDF)<-gsub("[:alnum:]*-meanFreq[:alnum:]*","-mean frequency",names(msDF))
cm<-colMeans(msDF)
#substr(colNames,1,regexpr("-",as.vector(colNames))[1:length(colNames)])
colNames<-names(cm)
f<-substr(colNames,1,regexpr("-",as.vector(colNames))[1:length(colNames)])
cmDF<-data.frame(cm,f)
names(cmDF)<-c("Mean","Activity")

meltcmDF<-melt(cmDF,id="Activity",vars=c("Mean"))

subset(data,!duplicated(data$ID))
activityMean<-subset(meltcmDF,!duplicated(meltcmDF$Activity))


