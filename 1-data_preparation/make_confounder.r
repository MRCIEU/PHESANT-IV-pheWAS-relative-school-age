homedir = Sys.getenv("HOME")

datadir=(paste0(homedir,"/Phesant_ageatschool/data/confounder"))

### Generate confounder file
### Adjusting for age, sex and assessment centre

# age, sex, assessment centre
confs = read.table(paste(datadir,'/variables_for_confounder.csv', sep=""), sep=',', header=1)
colnames(confs) = c("eid","x31_0_0","x52_0_0","x54_0_0","x54_1_0","x54_2_0","x1647_1_0","x1647_2_0","x1647_3_0","x21022_0_0")
print(dim(confs))

## process confounders into correct format

## convert assessment centre to indicator variables - reference category is 10003
confs$x54_0_0 = as.factor(confs$x54_0_0)
assCentre = model.matrix(~confs$x54_0_0)
assCentre = assCentre[,2:ncol(assCentre)]
confs = cbind(confs, assCentre)
confs$x54_0_0 = NULL

for (i in 11001:11023) {
        colnames(confs)[which(names(confs) == paste("confs$x54_0_0", i, sep=""))] <- paste("assCentre", i, sep="")
}


## basic checking

# min mean max age
min(confs$x21022_0_0)
max(confs$x21022_0_0)
mean(confs$x21022_0_0)

# number of each sex
unique(confs$x31_0_0)
length(which(confs$x31_0_0==0))
length(which(confs$x31_0_0==1))

# number of each assessment centre

for (i in 11001:11023) {
	varName=paste("x54_0_0", i, sep="")
	num0 = length(which(confs[[varName]]==0))
	num1 = length(which(confs[[varName]]==1))
	print(paste(varName, ": ", num0, " ", num1, sep=""))
}


## save confounder file - adjusting for age, sex and assessment centre

myconf = confs[,c("eid","x31_0_0","x21022_0_0","assCentre11001","assCentre11002","assCentre11003","assCentre11004","assCentre11005","assCentre11006","assCentre11007","assCentre11008","assCentre11009","assCentre11010","assCentre11011","assCentre11012","assCentre11013","assCentre11014","assCentre11016","assCentre11017","assCentre11018","assCentre11020","assCentre11021","assCentre11022","assCentre11023")]


write.table(myconf, paste(datadir,'/confounders-sex_age_asscen.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

