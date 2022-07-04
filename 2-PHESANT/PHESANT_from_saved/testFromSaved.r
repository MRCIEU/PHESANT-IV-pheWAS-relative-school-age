library("optparse")

option_list = list(
  make_option(c("-g", "--traitofinterestfile"), type="character", default=NULL, help="Trait of interest dataset file name", metavar="character"),
  make_option(c("-r", "--resDir"), type="character", default=NULL, help="resDir option should specify directory where results files should be stored", metavar="character"),
  make_option(c("-u", "--userId"), type="character", default="userId", help="userId option should specify user ID column in trait of interest and phenotype files [default= %default]", metavar="character"),
  make_option(c("-a", "--partIdx"), type="integer", default=NULL, help="Part index of phenotype (used to parellise)"),
  make_option(c("-b", "--numParts"), type="integer", default=NULL, help="Number of phenotype parts (used to parellise)"),
  make_option(c("-c", "--confounderfile"), type="character", default=NULL, help="Confounder file name", metavar="character"),
  make_option(c("-p", "--phenoDir"), type="character", default=NULL, help="Phenotype directory", metavar="character")
);
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

source('testContinuous.r')
source('testCategoricalOrdered.r')
source('testCategoricalUnordered.r')
source('testBinary.r')


## load confounders
confounders = read.table(opt$confounderfile, sep=',', header=1)

## load trait of interest
exposure = read.table(opt$traitofinterestfile, sep=',', header=1)

# make sure first column in trait of interest file is the participantID - all the other columns correspond to the trait of interest (i.e. are used as the exposure in our regression models)
stopifnot(colnames(exposure)[1] == opt$userId)


# clear log file
resLogFile = paste(opt$resDir, "results-log-", opt$partIdx, "-", opt$numParts, ".txt",sep="")
sink(resLogFile)
sink()



## get column names (minus participantID column) of the exposure variables - as many as are in the trait of interest file

traitofinterest <<- colnames(exposure[,2:ncol(exposure), drop=FALSE])
print("Column names of trait of interest")
print(traitofinterest)


## create empty results files

source('saveHeader.R')
#saveHeader(paste(opt$resDir,"results-logistic-binary-", opt$partIdx, "-", opt$numParts, ".txt",sep=""), traitofinterest)
#saveHeader(paste(opt$resDir,"results-linear-", opt$partIdx, "-", opt$numParts, ".txt",sep=""), traitofinterest)
saveHeader(paste(opt$resDir,"results-ordered-logistic-", opt$partIdx, "-", opt$numParts, ".txt",sep=""), traitofinterest)
#saveHeader(paste(opt$resDir,"results-multinomial-logistic-", opt$partIdx, "-", opt$numParts, ".txt",sep=""), traitofinterest)


## test each type of outcome

#print("Testing continuous outcomes")
#testContinuous(opt$resDir, opt$partIdx, opt$numParts, confounders, exposure, traitofinterest, opt$userId, opt$phenoDir)

print("Testing categorical ordered outcomes")
testCategoricalOrdered(opt$resDir, opt$partIdx, opt$numParts, confounders, exposure, traitofinterest, opt$userId, opt$phenoDir)

#print("Testing categorical unordered outcomes")
#testCategoricalUnordered(opt$resDir, opt$partIdx, opt$numParts, confounders, exposure, traitofinterest, opt$userId, opt$phenoDir)

#print("Testing binary outcomes")
#testBinary(opt$resDir, opt$partIdx, opt$numParts, confounders, exposure, traitofinterest, opt$userId, opt$phenoDir)



