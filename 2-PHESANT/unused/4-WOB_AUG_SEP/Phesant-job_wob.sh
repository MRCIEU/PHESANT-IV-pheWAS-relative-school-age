#!/bin/bash
#PBS -l walltime=360:00:00,nodes=1:ppn=1
#PBS -S /bin/bash
#PBS -e errors
#PBS -t 1-100
#------------------------------------------------------------------------------------

module add languages/R-3.3.1-ATLAS

pIdx=${PBS_ARRAYID}
np=100

homedir="${HOME}/Phesant_ageatschool/"

date

cd ${HOME}/Phesant_ageatschool/4-phesant/WAS/
Rscript phenomeScan.r \
--phenofile="${homedir}data/data_21753-phesant_header.csv" \
--traitofinterestfile="${homedir}data/exposure/exposure_wob_1.csv" \
--confounderfile="${homedir}data/confounder/confounders-sex_age_asscen.csv" \
--variablelistfile="${homedir}4-phesant/variable-info/outcome-info.tsv" \
--datacodingfile="${homedir}4-phesant/variable-info/data-coding-ordinal-info.txt" \
--resDir="${homedir}4-phesant/4-WOB_AUG_SEP/" \
--userId="eid" \
--traitofinterest="week" \
--genetic=FALSE \
--partIdx=$pIdx \
--numParts=$np



date
