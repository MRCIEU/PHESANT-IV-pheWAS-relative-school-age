
resDir = Sys.getenv("RES_DIR")
 
for (i in 1:200)
{

###Read in results files for each array
resultslinear = read.delim(paste(resDir,'/phesant/exposure2/results-linear-',i,'-200.txt', sep=""), sep=',', header=1)
resultsbinary = read.delim(paste(resDir,'/phesant/exposure2/results-logistic-binary-',i,'-200.txt', sep=""), sep=',', header=1)
resultsmultinomial = read.delim(paste(resDir,'/phesant/exposure2/results-multinomial-logistic-',i,'-200.txt', sep=""), sep=',', header=1)
resultsordered = read.delim(paste(resDir,'/phesant/exposure2/results-ordered-logistic-',i,'-200.txt', sep=""), sep=',', header=1)

if (nrow(resultslinear)>0) {
resultslinear$varType="cont"
}

if (nrow(resultsbinary)>0) {
resultsbinary$varType="binary"
}

if (nrow(resultsmultinomial)>0) {
resultsmultinomial$varType="unordcat"
}

if (nrow(resultsordered)>0) {
resultsordered$varType="ordcat"
}


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

if (i==1){
allres = combinedresults
} else {
allres = rbind(allres,combinedresults)
}

}

head(allres)

#Order according to p values (order dataframe by columnn)
allres = allres[order(allres$pvalue),]
head(allres)

write.table(allres, paste(resDir,'/phesant/exposure2/allres.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

