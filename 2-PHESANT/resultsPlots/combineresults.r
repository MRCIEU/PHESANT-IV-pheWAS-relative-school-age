resDir = Sys.getenv("RES_DIR")

##Read in results from exposures 1-3

exp1_res<-read.delim(paste(resDir,'/phesant/exposure1/allres_exp1.csv', sep=""), sep=',', header=1)
head(exp1_res)

exp2_res<-read.delim(paste(resDir,'/phesant/exposure2/allres.csv', sep=""), sep=',', header=1)
head(exp2_res)

exp3_res<-read.delim(paste(resDir,'/phesant/exposure3/allres_exp3.csv', sep=""), sep=',', header=1)
head(exp3_res)

##Keep only the columns we need (Get rid of varType as is NA and is duplicated in all exposures)

exp1_res<-subset(exp1_res, select=-c(varType))
exp2_res<-subset(exp2_res, select=-c(varType))
exp3_res<-subset(exp3_res, select=-c(varType))

##Change the column names to exposure 1 - 3

#Exposure 1
colnames(exp1_res)
names(exp1_res)[names(exp1_res) == "n"] <- "n_exp1"
names(exp1_res)[names(exp1_res) == "pvalue"] <- "pvalue_exp1"
head(exp1_res)

#Exposure 2
colnames(exp2_res)
names(exp2_res)[names(exp2_res) == "n"] <- "n_exp2"
names(exp2_res)[names(exp2_res) == "pvalue"] <- "pvalue_exp2"
head(exp2_res)


#Exposure 3
colnames(exp3_res)
names(exp3_res)[names(exp3_res) == "n"] <- "n_exp3"
names(exp3_res)[names(exp3_res) == "pvalue"] <- "pvalue_exp3"
head(exp3_res)

##Merge, sort & save combined results

#Merge exposures 1 & 2

print(dim(exp1_res))
print(dim(exp2_res))
exp1-2_res <- merge(exp1_res,exp2_res, by="varName", all.x = TRUE, all.y=TRUE)
print(dim(exp1-2_res))
head(exp1-2_res)

#Merge exposures 1-2 and 3
exp1-3_res <-merge(exp1-2_res,exp3_res, by="varName", all.x = TRUE, all.y=TRUE)
print(dim(exp1-3_res))
head(exp1-3_res)

#Sort according to p value for exposure 1
exp1-3_res <- exp1-3_res[order(exp1-3_res$pvalue_exp1),]
head(exp1-3_res)

#Save combined results file
write.table(allres, paste(resDir,'/phesant/combinedresults.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)
