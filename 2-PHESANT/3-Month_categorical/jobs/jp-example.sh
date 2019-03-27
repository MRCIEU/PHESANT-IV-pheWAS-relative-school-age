#!/bin/bash
#PBS -l walltime=360:00:00,nodes=1:ppn=1
#PBS -o output-all
#PBS -e errors-all
#PBS -t 1-100
#---------------------------------------------

cd $PBS_O_WORKDIR

module add languages/R-3.3.1-ATLAS

date


## this is my test example using the smoking data, to set up the mr-phewas using an exposure that has multiple columns

dataDir="${HOME}/2017-PHESANT-smoking-interaction/data/"
resultsDir="${HOME}/2019-school-age-for-kate/results/"

## swapped for testing exposure with multiple variables
expFile="${dataDir}confounders/confounders-main.csv"
confFile="${dataDir}snp/snp-withPhenIds-subset.csv"


phenodir="${dataDir}phenotypes/derived/PHESANTv0_17-derived/"

part=${PBS_ARRAYID}
np=200

cd ..
Rscript testFromSaved.r --userId="eid" --resDir=${resultsDir} --partIdx=${part} --numParts=${np} --confounderfile=${confFile} --phenoDir=${phenodir} --traitofinterestfile=${expFile}

date 

