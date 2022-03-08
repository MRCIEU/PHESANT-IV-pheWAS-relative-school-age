#!/bin/bash

#SBATCH --job-name=Extract_Phenotypes
#SBATCH --partition=veryshort
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1:0:00
#SBATCH --mem=100G

echo 'Extract_Phenotypes'
srun hostname


#------------------------------------------------------------------------------------

export PROJECT_DATA="/mnt/storage/scratch/bo18534/SchoolAgeMiniProject/"


#head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x31_'
#head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x52_'
#head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x54_'
#head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x21022_'
#head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x1647_'

cut -d ',' -f 11,41,46,47,48,49,9093,1009,1010,1011 ${PROJECT_DATA}/Original/data.48196.phesant.csv > ${PROJECT_DATA}/Derived/exposure_confounder_variables.csv

