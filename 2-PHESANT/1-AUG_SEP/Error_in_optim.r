#FOR X3829: Error "in optim"
#Error in optim(s0, fmin, gmin, method = "BFGS", ...): initial value in 'vmmin' is not finite

dataDir = Sys.getenv("PROJECT_DATA")

#Read in exposure, confounders & outcome data 
exposure = read.table(paste(dataDir,'Derived/exposure1-Sep_Aug.csv', sep=""), sep=',', header=1)
head(exposure)
confs = read.table(paste(dataDir,'Derived/confounders-sex_age.csv', sep=""), sep=',', header=1)
head(confs)
phenotype = read.table(paste(dataDir,'Original/phesant_saved-20211117/data-catord-15-200.txt', sep=""), sep=',', header=1)
head(phenotype)

#Just select the one outcome variable we want.
phenotype = phenotype[ ,c("userID", "X3829")]
head(phenotype)

**Change column name "userID" to "eid" in phenotype dataframe
colnames(phenotype)
names(phenotype)[names(phenotype) == "userID"] <- "eid"
colnames(phenotype) 

#Merge exposure & confounders into one dataframe
print(dim(exposure))
#64075     2
print(dim(confs))
#390427      3
exp_confs <- merge(exposure,confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(exp_confs))
#390427      4
head(exp_confs)
# eid Sep_Aug x31_0_0 x21022_0_0

#Merge phenotype with exposure/confounders
print(dim(phenotype))
#502448      2
data <- merge(phenotype,exp_confs, by="eid", all.x = TRUE, all.y=TRUE)
print(dim(data))
# 502448      5
head(data)
#eid X3829 Sep_Aug x31_0_0 x21022_0_0

#Load MASS library to get polr function
library (MASS)


# extract pheno and convert to factor
phenoFactor <- as.factor(data$X3829)

# check distribution of outcome
table(phenoFactor)
# 0     1     2     3     4     5     6
#79921  6077   693   177    51    17    14

# make confsPlusExp data frame
confsPlusExp <- data[,c('Sep_Aug', 'x21022_0_0', 'x31_0_0')]

# makes confounders only data frame
confsonly <- data[,c('x21022_0_0', 'x31_0_0')]


#Louise's regression code
fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)
#Warning message:
#In polr(phenoFactor ~ ., data = confsPlusExp, Hess = TRUE) :
#  design appears to be rank-deficient, so dropping some coefs

fitB <- polr(phenoFactor ~ ., data=confsonly, Hess=TRUE)
#Warning message:
#In polr(phenoFactor ~ ., data = confsonly, Hess = TRUE) :
#  design appears to be rank-deficient, so dropping some coefs



