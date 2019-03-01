#!/bin/bash
#PBS -l walltime=24:00:00,nodes=1:ppn=4
#PBS -S /bin/bash

#------------------------------------------------------------------------------------


head -n 1 ${PROJECTDATADIR}/data.21753.csv | sed 's/,/\n/g' | cat -n | grep '31-'
head -n 1 ${PROJECTDATADIR}/data.21753.csv | sed 's/,/\n/g' | cat -n | grep '52-'
head -n 1 ${PROJECTDATADIR}/data.21753.csv | sed 's/,/\n/g' | cat -n | grep '54-'
head -n 1 ${PROJECTDATADIR}/data.21753.csv | sed 's/,/\n/g' | cat -n | grep '21022-'
head -n 1 ${PROJECTDATADIR}/data.21753.csv | sed 's/,/\n/g' | cat -n | grep '1647-'


cut -d ',' -f 1,9,32,36,37,38,751,752,753,7075 ${PROJECTDATADIR}/data.21753.csv > ${HOME}/Phesant_ageatschool/data/confounder/variables_for_confounder.csv



