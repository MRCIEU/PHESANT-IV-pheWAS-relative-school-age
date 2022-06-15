resDir = Sys.getenv("RES_DIR")

#Read in combined results file
comb_res<-read.delim(paste(resDir,'/phesant/combinedresults.csv', sep=""), sep=',', header=1)
head(comb_res)
print(dim(comb_res))

#Create subset with exp1 pvalue under 3.50E-06 or exp2 pvalue under 2.26E-06 or exp3 pvalue under 2.23E-06
threshsub <-subset(comb_res, pvalue_exp1 < 3.50E-06 | pvalue_exp2 <2.26E-06 | pvalue_exp3 < 2.23E-06)
print(dim(threshsub))
head(thressub)
 
