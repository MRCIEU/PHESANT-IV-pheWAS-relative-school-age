#!/bin/bash
#PBS -l walltime=72:00:00,nodes=1:ppn=4
#PBS -S /bin/bash

#------------------------------------------------------------------------------------

cd ${HOME}/Phesant_ageatschool/PHESANT-IV-pheWAS-relative-school-age/1-data_preparation/ \

Rscript make_exposure.r \