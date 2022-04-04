#Restricting sample to who haven't withdrawn & just those born in England

dataDir = Sys.getenv("PROJECT_DATA")

variables = read.table(paste(dataDir,'/Derived/exposure_confounder_variables.csv', sep=""), sep=',', header=1)
print ("dim of original data")
print(dim(variables))
# 502,448  11

withdrawn = read.table(paste(dataDir,'/Original/meta.withdrawn.20220222.csv', sep=""), sep=',', header=FALSE)
print ("dim of withdrawn data")
print(dim(withdrawn))
#234 1

#Restrict to participants in England

variables = subset(variables,(x1647_0_0 == 1))
print ("dim of born in england subset")
print(dim(variables))
#390,454


#Remove cases that have withdrawn from UK Biobank
which(variables$eid %in% withdrawn$V1)
#27
variables <- variables[ ! variables$eid %in% withdrawn$V1, ]
print ("dim of cases not withdrawn data")
print(dim(variables))
#390427 11
#27 cases were removed



#Check whether any participants missing age

idx=which(is.na(variables$x21022_0_0))
print ("number of participants in england missing age")
print(length(idx))
#0

write.table(variables, paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)



