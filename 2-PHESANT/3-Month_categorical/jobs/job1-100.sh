#!/bin/bash

#SBATCH --job-name=phesant_exposure2
#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:0:00
#SBATCH --mem=100G
#SBATCH --array=1-100
echo 'phesant_exposure2'
srun hostname


#------------------------------------------------------------------------------------


cd $PBS_O_WORKDIR

module add languages/R-3.3.1-ATLAS

date

dataDir = Sys.getenv("PROJECT_DATA")
resDir = Sys.getenv("RES_DIR")


expFile="${dataDir}Derived/exposure2_month_indicator_variables.csv"
confFile="${dataDir}Derived/confounders-sex_age.csv"

phenodir="${dataDir}derived_phenotypes/"

part=${SLURM_ARRAY_TASK_ID}
np=200

cd ..
Rscript ../PHESANT_from_saved/testFromSaved.r --userId="eid" --resDir=${resultsDir} --partIdx=${part} --numParts=${np} --confounderfile=${confFile} --phenoDir=${phenodir} --traitofinterestfile=${expFile}

date 
