
testContinuous <- function(resDir, partNum, numParts, confounders, traitofinterest, traitofinterestname, userId, phenoDir) {

	resLogFile = paste(resDir, "results-log-", partNum, "-", numParts, ".txt",sep="")

        ## load phenotype data

        phenos = read.table(paste(phenoDir, '/data-cont-', partNum, '-', numParts, '.txt',sep=''), sep=',', header=1, comment.char="")

	if (ncol(phenos)==1) {
		return(NULL)
	}

	confNames = colnames(confounders)
        confNames = confNames[-which(confNames==userId)]
        phenoNames = colnames(phenos)
        phenoNames = phenoNames[-which(phenoNames=='userID')]

        ## merge datasets
        data = merge(traitofinterest, confounders, by=userId)
        data = merge(data, phenos, by.x=userId, by.y='userID')

	for (i in 1:length(phenoNames)) {

		varName = phenoNames[i]
		print(varName)

		varType=''
		pheno = data[,varName]

		sink(resLogFile, append=TRUE)
                cat(paste(varName, ' || linear || ', sep=''))
                sink()


		numNotNA = length(which(!is.na(pheno)))
		if (numNotNA<500) {
			sink(resLogFile, append=TRUE)
			cat('<500 in total (', numNotNA, ') || SKIP ',sep='')
			sink()
		}
		else {

		sink(resLogFile, append=TRUE)
                cat('testing || ')
                sink()

		# standardise outcome because it's continuous and normal (i.e. irnt)
		pheno = scale(pheno)

		confs = data[,confNames]
		confsPlusExp = data[,c(traitofinterestname, confNames)]
		print(head(confsPlusExp))
		print(head(confs))

		## linear regression model
		fit <- lm(pheno ~ ., data=confsPlusExp)

		## baseline
		fitB <- lm(pheno ~  ., data=confs)

		## compare model to baseline model
                require(lmtest)
                lres = lrtest(fit, fitB)
                modelP = lres[2,"Pr(>Chisq)"]

		## save result to file
		sink(resLogFile, append=TRUE)
		cat("SUCCESS results-linear")
		sink()

		write(paste(varName, varType, numNotNA, modelP, sep=","), file=paste(resDir,"results-linear-",partNum, "-", numParts,".txt", sep=""), append=TRUE)
		}

		sink(resLogFile, append=TRUE)
		cat("\n")
		sink()

	}

}



