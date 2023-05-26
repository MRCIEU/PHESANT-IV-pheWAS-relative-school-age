#!/bin/bash

#SBATCH --job-name=jcombineresults
#SBATCH --partition=veryshort
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --mem=100G
#SBATCH --account=xxxxxx


#-----------------------------------------------------------------------------------------------------

cd $SLURM_SUBMIT_DIR

module load languages/r/4.1.0

export RES_DIR="${HOME}/2022SchoolAge/results"


date

Rscript combineresults.r
 
date

