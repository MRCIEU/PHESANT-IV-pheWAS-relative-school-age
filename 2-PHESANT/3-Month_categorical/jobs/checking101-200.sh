#!/bin/bash
for i in {101..200}
do
   echo "Array $i"
   grep GMT slurm-10190682_${i}.out
done

