resDir = Sys.getenv("RES_DIR")

#Read in combined results file
comb_res<-read.delim(paste(resDir,'/phesant/combinedresults.csv', sep=""), sep=',', header=1)
head(comb_res)
print(dim(comb_res))

#Create subset with exp1 pvalue under 3.33E-06 or exp3 pvalue under 2.16E-06
threshsub <-subset(comb_res, pvalue_exp1 < 3.33E-06 | pvalue_exp3 < 2.16E-06)
print(dim(threshsub))

head(threshsub)
 
#Save threshold results file
write.table(threshsub, paste(resDir,'/phesant/thresholdsubset.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)
