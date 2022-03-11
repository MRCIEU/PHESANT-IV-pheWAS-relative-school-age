dataDir = Sys.getenv("PROJECT_DATA")
resDir = Sys.getenv("RES_DIR")

### Generate confounder file
### Adjusting for age and sex

# age and sex
confs = read.table(paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv', sep=""), sep=',', header=1)


## basic checking

# min mean max age
min(confs$x21022_0_0, na.rm = TRUE)
max(confs$x21022_0_0, na.rm = TRUE)
mean(confs$x21022_0_0, na.rm = TRUE)


# number of each sex
unique(confs$x31_0_0)
length(which(confs$x31_0_0==0))
length(which(confs$x31_0_0==1))


## save confounder file - adjusting for age and sex

confs = confs[, c("eid","x31_0_0","x21022_0_0")]


write.table(confs, paste(dataDir,'/Derived/confounders-sex_age.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

