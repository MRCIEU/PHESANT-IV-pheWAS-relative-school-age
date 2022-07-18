#FOR X1458: Error "in profile.polr"
# Error in profile.polr(object, which = parm, alpha = (1 - level)/4, trace = trace): profiling has found a better solution, so original fit had not converged

dataDir = Sys.getenv("PROJECT_DATA")

#Read in exposure, confounders & outcome data
exposure = read.table(paste(dataDir,'Derived/exposure2_month_indicator_variables.csv', sep=""), sep=',', header=1)
head(exposure)
confs = read.table(paste(dataDir,'Derived/confounders-sex_age.csv', sep=""), sep=',', header=1)
head(confs)
phenotype = read.table(paste(dataDir,'Original/phesant_saved-20211117/data-catord-9-200.txt', sep=""), sep=',', header=1)
head(phenotype)

#Just select the one outcome variable we want.
phenotype = phenotype[ ,c("userID", "X1458")]

**Change column name "userID" to "eid" in phenotype dataframe
colnames(phenotype)
names(phenotype)[names(phenotype) == "userID"] <- "eid"
colnames(phenotype)

#Merge exposure & confounders into one dataframe
print(dim(exposure))
#390427     12
print(dim(confs))
#390427      3
exp_confs <- merge(exposure,confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(exp_confs))
# 390427     14
head(exp_confs)
#eid Oct Nov Dec Jan Feb Mar Apr May Jun Jul Aug x31_0_0 x21022_0_0

#Merge phenotype with exposure/confounders
print(dim(phenotype))
#502448      2
data <- merge(phenotype,exp_confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(data))
#502448     15
head(data)
#eid X1458 Oct Nov Dec Jan Feb Mar Apr May Jun Jul Aug x31_0_0 x21022_0_0

#Load MASS library to get polr function
library (MASS)

# extract pheno and convert to factor
phenoFactor <- as.factor(data$X1458)

# check distribution of outcome
table(phenoFactor)
# 0      1      2
#154199 133325 189550

# make confsPlusExp data frame
confsPlusExp <- data[,c('eid', 'Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'x21022_0_0', 'x31_0_0')]

#Louise's regression code
fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)
#No error

#Make confs only dataframe
confsonly <- data[,c('x21022_0_0', 'x31_0_0')]

fitB <- polr(phenoFactor ~ ., data=confsonly, Hess=TRUE)
#No error

