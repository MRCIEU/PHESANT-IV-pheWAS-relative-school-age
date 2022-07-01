#FOR X2375: Error "in if"

dataDir = Sys.getenv("PROJECT_DATA")

exposure = read.table(paste(dataDir,'Derived/exposure1-Sep_Aug.csv', sep=""), sep=',', header=1)
head(exposure)
confs = read.table(paste(dataDir,'Derived/confounders-sex_age.csv', sep=""), sep=',', header=1)
head(confs)
phenotype = read.table(paste(dataDir,'Original/phesant_saved-20211117/data-catord-12-200.txt', sep=""), sep=',', header=1)
head(phenotype)
phenotype = phenotype[ ,c("userID", "2375")]

fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)
fitB <- polr(phenoFactor ~ ., data=confs, Hess=TRUE)
