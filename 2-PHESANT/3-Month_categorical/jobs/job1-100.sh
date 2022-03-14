#!/bin/bash

#SBATCH --job-name=phesant_exposure2
#SBATCH --partition=veryshort
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1:0:00
#SBATCH --mem=100G

echo 'phesant_exposure2'
srun hostname


#------------------------------------------------------------------------------------
#---------------------------------------------

cd $PBS_O_WORKDIR

module add languages/R-3.3.1-ATLAS

date

dataDir = Sys.getenv("PROJECT_DATA")
resDir = Sys.getenv("RES_DIR")


expFile="${dataDir}Derived/exposure2_month_indicator_variables.csv"
confFile="${dataDir}Derived/confounders-sex_age.csv"

phenodir="${dataDir}derived_phenotypes/"

part=${PBS_ARRAYID}
np=200

cd ..
Rscript testFromSaved.r --userId="eid" --resDir=${resultsDir} --partIdx=${part} --numParts=${np} --confounderfile=${confFile} --phenoDir=${phenodir} --traitofinterestfile=${expFile}

date 
