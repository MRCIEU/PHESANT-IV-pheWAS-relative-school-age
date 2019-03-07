homedir = Sys.getenv("HOME")

datadir=(paste0(homedir,"/Phesant_ageatschool/data"))

### Generate confounder file
### Adjusting for age, sex and assessment centre

# age, sex, assessment centre
DATA = read.table(paste(datadir,'/FollowUp_variables.csv', sep=""), sep=',', header=1)
print(dim(DATA))

## process confounders into correct format

## convert assessment centre to indicator variables - reference category is 10003
DATA$x54_0_0 = as.factor(DATA$x54_0_0)
assCentre = model.matrix(~DATA$x54_0_0)
assCentre = assCentre[,2:ncol(assCentre)]
DATA = cbind(DATA, assCentre)
DATA$x54_0_0 = NULL

for (i in 11001:11023) {
        colnames(DATA)[which(names(DATA) == paste("DATA$x54_0_0", i, sep=""))] <- paste("assCentre", i, sep="")
}


## basic checking

# min mean max age
min(DATA$x21022_0_0)
max(DATA$x21022_0_0)
mean(DATA$x21022_0_0)

# number of each sex
unique(DATA$x31_0_0)
length(which(DATA$x31_0_0==0))
length(which(DATA$x31_0_0==1))

# number of each assessment centre

for (i in 11001:11023) {
	varName=paste("x54_0_0", i, sep="")
	num0 = length(which(DATA[[varName]]==0))
	num1 = length(which(DATA[[varName]]==1))
	print(paste(varName, ": ", num0, " ", num1, sep=""))
}



DATA["Auf_Sep"] = NA
DATA$Aug_Sep[DATA$52_0_0 == 8] = 0
DATA$Aug_Sep[DATA$52_0_0 == 9] = 1 


DATA["recode_month"] = NA

DATA$recode_month[DATA$x52_0_0 == 9] = 0
DATA$recode_month[DATA$x52_0_0 == 10] = 1
DATA$recode_month[DATA$x52_0_0 == 11] = 2
DATA$recode_month[DATA$x52_0_0 == 12] = 3
DATA$recode_month[DATA$x52_0_0 == 1] = 4
DATA$recode_month[DATA$x52_0_0 == 2] = 5
DATA$recode_month[DATA$x52_0_0 == 3] = 6
DATA$recode_month[DATA$x52_0_0 == 4] = 7
DATA$recode_month[DATA$x52_0_0 == 5] = 8
DATA$recode_month[DATA$x52_0_0 == 6] = 9
DATA$recode_month[DATA$x52_0_0 == 7] = 10
DATA$recode_month[DATA$x52_0_0 == 8] = 11


DATA = exp_sub_1
DATA["Oct"]= 0
DATA["Nov"]= 0
DATA["Dec"]= 0
DATA["Jan"]= 0
DATA["Feb"]= 0
DATA["Mar"]= 0
DATA["Apr"]= 0
DATA["May"]= 0
DATA["Jun"]= 0
DATA["Jul"]= 0
DATA["Aug"]= 0

DATA$Oct[DATA$x52_0_0 == 10] = 1
DATA$Nov[DATA$x52_0_0 == 11] = 1
DATA$Dec[DATA$x52_0_0 == 12] = 1
DATA$Jan[DATA$x52_0_0 == 1] = 1
DATA$Feb[DATA$x52_0_0 == 2] = 1
DATA$Mar[DATA$x52_0_0 == 3] = 1
DATA$Apr[DATA$x52_0_0 == 4] = 1
DATA$May[DATA$x52_0_0 == 5] = 1
DATA$Jun[DATA$x52_0_0 == 6] = 1
DATA$Jul[DATA$x52_0_0 == 7] = 1
DATA$Aug[DATA$x52_0_0 == 8] = 1

DATA$Oct[DATA$x52_0_0 == NA] = NA
DATA$Nov[DATA$x52_0_0 == NA] = NA
DATA$Dec[DATA$x52_0_0 == NA] = NA
DATA$Jan[DATA$x52_0_0 == NA] = NA
DATA$Feb[DATA$x52_0_0 == NA] = NA
DATA$Mar[DATA$x52_0_0 == NA] = NA
DATA$Apr[DATA$x52_0_0 == NA] = NA
DATA$May[DATA$x52_0_0 == NA] = NA
DATA$Jun[DATA$x52_0_0 == NA] = NA
DATA$Jul[DATA$x52_0_0 == NA] = NA
DATA$Aug[DATA$x52_0_0 == NA] = NA

print(dim(DATA))

write.table(DATA, paste(datadir,'/FollowUp_variables_proc',sep=""), sep=',', row.names=FALSE, quote = FALSE)