#!/bin/bash
#PBS -l walltime=360:00:00,nodes=1:ppn=1
#PBS -o output-all
#PBS -e errors-all
#PBS -t 1-100
#---------------------------------------------

cd $PBS_O_WORKDIR

module add languages/R-3.3.1-ATLAS

date


dataDir="${HOME}/Phesant_ageatschool/data/"
resultsDir="${HOME}/Phesant_ageatschool/4-phesant/3-Month_cat/"

expFile="${dataDir}exposure/exposure_2.csv"
confFile="${dataDir}confounder/confounders-sex_age_asscen.csv"

phenodir="${dataDir}derived_phenotypes/"

part=${PBS_ARRAYID}
np=200

cd ..
Rscript testFromSaved.r --userId="eid" --resDir=${resultsDir} --partIdx=${part} --numParts=${np} --confounderfile=${confFile} --phenoDir=${phenodir} --traitofinterestfile=${expFile}

date 