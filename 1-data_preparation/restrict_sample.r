#Restricting sample to just those born in England

dataDir = Sys.getenv("PROJECT_DATA")

variables = read.table(paste(dataDir,'/Derived/exposure_confounder_variables.csv', sep=""), sep=',', header=1)
print ("dim of original data")
print(dim(variables))
# 502,448


#Restrict to participants in England

variables = subset(variables,(x1647_0_0 == 1))
print ("dim of born in england subset")
print(dim(variables))
#390,454


#Check whether any participants missing age

idx=which(is.na(variables$x21022_0_0))
print ("number of participants in england missing age")
print(length(idx))
#0

write.table(variables, paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)



