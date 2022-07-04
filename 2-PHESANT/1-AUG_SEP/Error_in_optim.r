#FOR X3829: Error "in optim"

dataDir = Sys.getenv("PROJECT_DATA")

#Read in exposure, confounders & outcome data 
exposure = read.table(paste(dataDir,'Derived/exposure1-Sep_Aug.csv', sep=""), sep=',', header=1)
head(exposure)
confs = read.table(paste(dataDir,'Derived/confounders-sex_age.csv', sep=""), sep=',', header=1)
head(confs)
phenotype = read.table(paste(dataDir,'Original/phesant_saved-20211117/data-catord-9-200.txt', sep=""), sep=',', header=1)
head(phenotype)

#Just select the one outcome variable we want.
phenotype = phenotype[ ,c("userID", "X3829")]

**Change column name "userID" to "eid" in phenotype dataframe
colnames(phenotype)
names(phenotype)[names(phenotype) == "userID"] <- "eid"
 
#Merge exposure & confounders into one dataframe
print(dim(exposure))
print(dim(confs))
exp_confs <- merge(exposure,confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(exp_confs))
head(exp_confs)

#Merge phenotype with exposure/confounders
print(dim(phenotype))
data <- merge(phenotype,exp_confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(data))
head(data)

#Load MASS library to get polr function
library (MASS)

#Louise's regression code
#fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)

#fitB <- polr(phenoFactor ~ ., data=confs, Hess=TRUE)
