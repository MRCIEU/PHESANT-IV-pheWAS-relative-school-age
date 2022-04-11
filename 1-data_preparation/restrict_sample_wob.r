#Restrict week of birth data to those in England & not withdrawn

dataDir = Sys.getenv("PROJECT_DATA")

wob = read.table(paste(dataDir,'/Original/app_16729_wob.csv', sep=""), sep=',', header=1)
expconf = read.table(paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv', sep=""), sep=',', header=1)

#Want to remove cases that are not in exposure_confounder_subset.csv
nrow(wob)
#502536

##doesnt work
##which(wob$eid !%in% expconf$eid)

wob = wob[wob$eid %in% expconf$eid, ]
print ("dim of wob cases in England & not withdrawn")
print(dim(wob))
#390427 2

write.table(wob, paste(dataDir,'/Derived/wob_subset.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)
