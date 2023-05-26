resDir = Sys.getenv("RES_DIR")

##Read in results from exposures 1-3

exp1_res<-read.delim(paste(resDir,'/phesant/exposure1/allres_exp1.csv', sep=""), sep=',', header=1)
head(exp1_res)

exp1_n = nrow(exp1_res)
exp1_res = exp1_res[order(exp1_res$pvalue),]
exp1_res$rank = seq(1, nrow(exp1_res))
exp1_res$fdr_p_thresh_exp1 = 0.05*exp1_res$rank/exp1_n
exp1_res$belowFDRThresh_exp1 = exp1_res$pvalue < exp1_res$fdr_p_thresh_exp1
exp1_res$rank = NULL


exp2_res<-read.delim(paste(resDir,'/phesant/exposure2/allres.csv', sep=""), sep=',', header=1)
head(exp2_res)

exp2_n = nrow(exp2_res)
exp2_res = exp2_res[order(exp2_res$pvalue),]
exp2_res$rank = seq(1, nrow(exp2_res))
exp2_res$fdr_p_thresh_exp2 = 0.05*exp2_res$rank/exp2_n
exp2_res$belowFDRThresh_exp2 = exp2_res$pvalue < exp2_res$fdr_p_thresh_exp2

exp2_res$rank = NULL

exp3_res<-read.delim(paste(resDir,'/phesant/exposure3/allres_exp3.csv', sep=""), sep=',', header=1)
head(exp3_res)

exp3_n = nrow(exp3_res)
exp3_res = exp3_res[order(exp3_res$pvalue),]
exp3_res$rank = seq(1, nrow(exp3_res))
exp3_res$fdr_p_thresh_exp3 = 0.05*exp3_res$rank/exp3_n
exp3_res$belowFDRThresh_exp3 = exp3_res$pvalue < exp3_res$fdr_p_thresh_exp3

exp3_res$rank = NULL

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
#14275, 7
print(dim(exp2_res))
#22136, 47
exp1_2res <- merge(exp1_res,exp2_res, by="varName", all.x = TRUE, all.y=TRUE)
print(dim(exp1_2res))
#22136, 53
head(exp1_2res)

#Merge exposures 1-2 and 3
print(dim(exp3_res))
#22399, 7
exp1_3res <-merge(exp1_2res,exp3_res, by="varName", all.x = TRUE, all.y=TRUE)
print(dim(exp1_3res))
#22459, 59
head(exp1_3res)

#Sort according to p value for exposure 1
exp1_3res <- exp1_3res[order(exp1_3res$pvalue_exp1),]
head(exp1_3res)

#Save combined results file
write.table(exp1_3res, paste(resDir,'/phesant/combinedresults.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)
