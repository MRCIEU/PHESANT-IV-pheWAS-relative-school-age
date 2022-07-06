#FOR X1458: Error "in profile.polr"

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

# extract pheno and convert to factor
phenoFactor <- as.factor(data$X1458)

# check distribution of outcome
table(phenoFactor)

# make confsPlusExp data frame
#**Need to change Sep_Aug to exposure 2 column names: 
#confsPlusExp <- data[,c('Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'x21022_0_0', 'x31_0_0')]

#Louise's regression code
#fit <- polr(phenoFactor ~ ., data=confsPlusExp, Hess=TRUE)

#fitB <- polr(phenoFactor ~ ., data=confs, Hess=TRUE)
