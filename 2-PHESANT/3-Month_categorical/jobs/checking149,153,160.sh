#!/bin/bash
for i in {149,153,160}
do
   echo "Array $i"
   grep GMT slurm-10167143_${i}.out
done
