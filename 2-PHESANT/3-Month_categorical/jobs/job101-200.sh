#!/bin/bash

#SBATCH --job-name=phesant_exposure2
#SBATCH --partition=cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=100G
#SBATCH --array=101-200
echo 'phesant_exposure2'
srun hostname


#------------------------------------------------------------------------------------


cd $SLURM_SUBMIT_DIR

module load languages/r/4.1.0

date

export RES_DIR="${HOME}/2022SchoolAge/results/phesant/exposure2/"
export PROJECT_DATA="/mnt/storage/scratch/bo18534/SchoolAgeMiniProject/"


expFile="${PROJECT_DATA}Derived/exposure2_month_indicator_variables.csv"
confFile="${PROJECT_DATA}Derived/confounders-sex_age.csv"

phenodir="${PROJECT_DATA}/Original/phesant_saved-20211117/"

part=${SLURM_ARRAY_TASK_ID}
np=200

cd $HOME/2022SchoolAge/code/PHESANT-IV-pheWAS-relative-school-age/2-PHESANT/PHESANT_from_saved/

Rscript testFromSaved.r --userId="eid" --resDir=${RES_DIR} --partIdx=${part} --numParts=${np} --confounderfile=${confFile} --phenoDir=${phenodir} --traitofinterestfile=${expFile}

date



