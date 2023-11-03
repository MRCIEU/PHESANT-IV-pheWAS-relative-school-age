
### written by Louise Millard
### tests association of variables that should not be associated with the IV is the IV assumptions are satisfied


## load data

datadir=Sys.getenv('PROJECT_DATA')
resdir=Sys.getenv('RES_DIR')

sink(paste0(resdir, '/basic-assocs.txt'))

# IV
ivfile=paste0(datadir, 'Derived/exposure1-Sep_Aug.csv')
ivdata=read.csv(ivfile)

# variables that should not be associated with the IV
varfile=paste0(datadir,'/Derived/basic-assoc-vars.csv')
vardata=read.csv(varfile)

# merge data together
dataComb = merge(ivdata, vardata, by='eid', all.x=TRUE, all.y=FALSE)

summary(dataComb)

## test associations

# sex
print('Testing sex')
mylogit <- glm(Sep_Aug ~ x31_0_0, data=dataComb, family="binomial")
cis = confint(mylogit, "x31_0_0", level=0.95)
sumx = summary(mylogit)
print(paste0(sumx$coefficients['x31_0_0', "Estimate"], ' [', cis["2.5 %"], ',', cis["97.5 %"], ']'))

# year at birth
print('Testing year at birth')
mylogit <- glm(Sep_Aug ~ x34_0_0, data=dataComb, family="binomial")
cis = confint(mylogit, "x34_0_0", level=0.95)
sumx = summary(mylogit)
print(paste0(sumx$coefficients['x34_0_0', "Estimate"], ' [', cis["2.5 %"], ',', cis["97.5 %"], ']'))

# birthweight
print('Testing birthweight')
mylogit <- glm(Sep_Aug ~ x20022_0_0, data=dataComb, family="binomial")
cis = confint(mylogit, "x20022_0_0", level=0.95)
sumx = summary(mylogit)
print(paste0(sumx$coefficients['x20022_0_0', "Estimate"], ' [', cis["2.5 %"], ',', cis["97.5 %"], ']'))

# assessment centre
print('Testing assessment centre (location proxy)')
library(fastDummies)
acDummies = dummy_cols(dataComb$x54_0_0, remove_most_frequent_dummy=TRUE)
acDummies$.data = NULL

mylogit <- glm(dataComb$Sep_Aug ~ ., data=acDummies, family="binomial")
cis = confint(mylogit, level=0.95)
sumx = summary(mylogit)

print(cis)
print(sumx)

sink()

