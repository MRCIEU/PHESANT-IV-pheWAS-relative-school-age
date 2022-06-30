
testCategoricalOrdered <- function(resDir, partNum, numParts, confounders, traitofinterest, traitofinterestname, userId, phenoDir) {

	require(MASS)
	require(lmtest)

	resLogFile = paste(resDir, "results-log-", partNum, "-", numParts, ".txt",sep="")

        ## load phenotype data

        phenos = read.table(paste(phenoDir, '/data-catord-', partNum, '-', numParts, '.txt',sep=''), sep=',', header=1, comment.char="")

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
                cat(paste(varName, ' || catord || ', sep=''))
                sink()

		varType=''
		pheno = data[,varName]
		phenoFactor = factor(pheno)

		uniqVar = unique(na.omit(pheno))
		orderStr = setOrderString(uniqVar)

		sink(resLogFile, append=TRUE)
		cat("order: ", orderStr, " || ", sep="")
		sink()

		numNotNA = length(which(!is.na(pheno)))
		if (numNotNA<500) {
			print('<500 in total')
			sink(resLogFile, append=TRUE)
                        cat('<500 in total (', numNotNA, ') || SKIP ',sep='')
                        sink()
		}
		else if (length(uniqVar)<=1) {
                        print('<3 unique values')
                        sink(resLogFile, append=TRUE)
                        cat('<3 unique values (', length(uniqVar), ') || SKIP ',sep='')
                        sink()

                }
		else if (length(uniqVar)==2) {
			# binary outcome

			sink(resLogFile, append=TRUE)
			cat("binary outcome || ")
			sink()

			exp = data[,traitofinterestname]
	                confs = data[,confNames]

			confsPlusExp = data[,c(traitofinterestname, confNames)]
	                confsPlusExp = confsPlusExp[ix,]

			myBinaryRegression(confsPlusExp, confs, phenoFactor, partNum, numParts, resDir, varName)

			sink(resLogFile, append=TRUE)
	                cat("SUCCESS results-binary")
	                sink()

		}
		else {

		sink(resLogFile, append=TRUE)
              	cat('testing || ')
             	sink()


		exp = data[,traitofinterestname]
		confs = data[,confNames]

		## removing rows with missing outcome from all data used in regression
		ix = which(!is.na(phenoFactor))
		phenoFactor = phenoFactor[ix]
		confs = confs[ix,]
		confsPlusExp = data[ix,c(traitofinterestname, confNames)]
#              	confsPlusExp = confsPlusExp[ix,]

		tryCatch({

		## ordered logistic regression

		fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)

		## baseline
		fitB <- polr(phenoFactor ~ ., data=confs, Hess=TRUE)

		if (fit$convergence == 0 & fitB$convergence == 0) {

		## compare model to baseline model
                require(lmtest)
                lres = lrtest(fit, fitB)
                modelP = lres[2,"Pr(>Chisq)"]

		# get numbers overall, we store this as part of the results
		numNotNA = length(which(!is.na(phenoFactor)))

		## save result to file
		sink(resLogFile, append=TRUE)
                cat("SUCCESS results-catord")
                sink()

		source('saveCatOrdResult.R')
                saveCatOrdResult(varName, varType, numNotNA, modelP, paste(resDir,"results-ordered-logistic-",partNum, "-", numParts,".txt", sep=""), traitofinterestname, fit)



		}
                else {
                        sink(resLogFile, append=TRUE)
                        cat("MODEL DID NOT CONVERGE")
                        sink()
                }


		### END TRYCATCH
		}, error = function(e) {
                        sink(resLogFile, append=TRUE)
                        cat(paste("ERROR:", varName,gsub("[\r\n]", "", e), sep=" "))
			sink()
		})


		}

		sink(resLogFile, append=TRUE)
                cat("\n")
                sink()

	}
}



setOrderString <- function(uniqVar) {


	orderStr=""

		# create order str by appending each value
               	uniqVarSorted = sort(uniqVar)
                first=1;
                for (i in uniqVarSorted) {
                        if (first==0) {
                                orderStr = paste(orderStr, "|",	sep="")
                        }
			if (i>=0) # ignore missing values
                        	orderStr = paste(orderStr, i, sep="")
				first=0;
			end
                }
	return(orderStr)
}
