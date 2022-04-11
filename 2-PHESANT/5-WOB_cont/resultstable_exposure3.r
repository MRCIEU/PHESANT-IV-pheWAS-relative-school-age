resDir = Sys.getenv("RES_DIR")

allres = data.frame(varName=character(), varType=character(), n=double(), pvalue=double())

for (i in 1:200)
{

###Read in results files for each array
resultslinear = read.delim(paste(resDir,'/phesant/exposure3/results-linear-',i,'-200.txt', sep=""), sep=',', header=1)
resultsbinary = read.delim(paste(resDir,'/phesant/exposure3/results-logistic-binary-',i,'-200.txt', sep=""), sep=',', header=1)
resultsmultinomial = read.delim(paste(resDir,'/phesant/exposure3/results-multinomial-logistic-',i,'-200.txt', sep=""), sep=',', header=1)
resultsordered = read.delim(paste(resDir,'/phesant/exposure3/results-ordered-logistic-',i,'-200.txt', sep=""), sep=',', header=1)

#Check contents of dataframes
head(resultslinear)
nrow(resultslinear)
head(resultsbinary)
nrow(resultsbinary)
head(resultsmultinomial)
nrow(resultsmultinomial)
head(resultsordered)
nrow(resultsordered)


#Combine results - append the different dataframes using rbind()
combinedresults = rbind(resultslinear, resultsbinary, resultsmultinomial, resultsordered)
nrow(combinedresults)

allres = rbind(allres,combinedresults)

}


#Order according to p values (order dataframe by columnn)
allres = allres[order(allres$pvalue),]
head(allres)

write.table(allres, paste(resDir,'/phesant/exposure3/allres_exp3.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)
