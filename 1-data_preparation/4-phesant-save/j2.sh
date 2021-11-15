#!/bin/bash
#PBS -l walltime=360:00:00,nodes=1:ppn=1
#PBS -o output2
#PBS -e errors2
#PBS -t 101-200
#---------------------------------------------



module add languages/R-4.0.3-gcc9.1.0 

date

dataDir="${HOME}/2019-school-age-for-kate/data/"
codeDir="${HOME}/2019-school-age-for-kate/code/PHESANT/WAS/"
varListDir="${HOME}/2019-school-age-for-kate/code/PHESANT/variable-info/"


outcomeFile="${dataDir}/data.48196.phesant.csv"
varListFile="${varListDir}outcome-info.tsv"
dcFile="${varListDir}data-coding-ordinal-info.txt"
resDir="${HOME}/2019-school-age-for-kate/data/PHESANT-saved/"

# start and end index of phenotypes
pIdx=${PBS_ARRAYID}
np=200

cd $codeDir
Rscript ${codeDir}phenomeScan.r --partIdx=$pIdx --numParts=$np --phenofile=${outcomeFile} --variablelistfile=${varListFile} --datacodingfile=${dcFile} --resDir=${resDir} --userId="eid" --save



date



