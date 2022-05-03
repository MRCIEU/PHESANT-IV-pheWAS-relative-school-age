
testBinary <- function(resDir, partNum, numParts, confounders, traitofinterest, traitofinterestname, userId, phenoDir) {


	resLogFile = paste(resDir, "results-log-", partNum, "-", numParts, ".txt",sep="")

        ## load phenotype data

        phenos = read.table(paste(phenoDir, '/data-binary-', partNum, '-', numParts, '.txt',sep=''), sep=',', header=1, comment.char="")

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

		sink(resLogFile, append=TRUE)
                cat(paste(varName, ' || binary || ', sep=''))
                sink()

		varType=''

		pheno = data[,varName]
		phenoFactor = factor(pheno)
		facLevels = levels(phenoFactor)
		idxTrue = length(which(phenoFactor==facLevels[1]))
		idxFalse = length(which(phenoFactor==facLevels[2]))
		numNotNA = length(which(!is.na(phenoFactor)))
 
	        if (idxTrue<10 || idxFalse<10) {
			print('<10')
			sink(resLogFile, append=TRUE)
                        cat(paste('<10 (',idxTrue,'/',idxFalse,' || SKIP ',sep=''))
                        sink()
		}
		else if (numNotNA<500) {	
			print('<500 in total')
			sink(resLogFile, append=TRUE)
			cat('<500 in total (', numNotNA, ') || SKIP ',sep='')
                        sink()
		}
		else {

		sink(resLogFile, append=TRUE)
                cat('testing || ')
                sink()

		confs = data[,confNames]
		confsPlusExp = data[,c(traitofinterestname, confNames)]

		phenoFactor = factor(pheno)

		myBinaryRegression(confsPlusExp, confs, phenoFactor, partNum, numParts, resDir, varName)

		## save result to file
		sink(resLogFile, append=TRUE)
                cat("SUCCESS results-binary")
                sink()

		}

		sink(resLogFile, append=TRUE)
                cat("\n")
                sink()

	}
}



myBinaryRegression <- function(confsPlusExp, confs, phenoFactor, partNum, numParts, resDir, varName) {

	print(unique(phenoFactor))

	varType=''

		## binary logistic regression
                fit <- glm(phenoFactor ~ ., data=confsPlusExp, family="binomial")

		## baseline
		fitB <- glm(phenoFactor ~ ., data=confs, family="binomial")

		if (fit$converged == TRUE & fitB$converged == TRUE) {

		## compare model to baseline model
                require(lmtest)
                lres = lrtest(fit, fitB)
                modelP = lres[2,"Pr(>Chisq)"]

		# get numbers in categories and overall, we store this as part of the results
		facLevels = levels(phenoFactor)
                idxTrue = length(which(phenoFactor==facLevels[1]))
                idxFalse = length(which(phenoFactor==facLevels[2]))
                numNotNA = length(which(!is.na(phenoFactor)))

		sink(resLogFile, append=TRUE)
                cat(paste(varName, varType, paste(idxTrue,"/",idxFalse,"(",numNotNA,")",sep=""), modelP, sep=","))
		cat(' || ')
                sink()

                ## save result to file

		source('saveBinaryResult.R')
                saveBinaryResult(varName, varType, paste(idxTrue,"/",idxFalse,"(",numNotNA,")",sep=""), modelP, paste(resDir,"results-logistic-binary-",partNum, "-", numParts,".txt", sep=""), traitofinterestname, fit)



		}
		else {
			sink(resLogFile, append=TRUE)
			cat("MODEL DID NOT CONVERGE")
			sink()
		}

}
