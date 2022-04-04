dataDir = Sys.getenv("PROJECT_DATA")
resDir = Sys.getenv("RES_DIR")

### Generate confounder file
### Adjusting for age and sex

# age and sex
confs = read.table(paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv', sep=""), sep=',', header=1)


## basic checking

# min mean max age
min(confs$x21022_0_0, na.rm = TRUE)
#38
max(confs$x21022_0_0, na.rm = TRUE)
#73
mean(confs$x21022_0_0, na.rm = TRUE)
#56.70664
sd(confs$x21022_0_0, na.rm = TRUE)
#8.057128

# number of each sex
unique(confs$x31_0_0)
#0 1 (0=Female, 1=Male)
length(which(confs$x31_0_0==0))
#210,924
length(which(confs$x31_0_0==1))
#179503

## save confounder file - adjusting for age and sex

confs = confs[, c("eid","x31_0_0","x21022_0_0")]


write.table(confs, paste(dataDir,'/Derived/confounders-sex_age.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

