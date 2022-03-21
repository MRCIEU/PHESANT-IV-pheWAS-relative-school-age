#!/bin/bash
for i in {1..100}
do
   echo "Array $i"
   grep GMT slurm-10162110_${i}.out
done
