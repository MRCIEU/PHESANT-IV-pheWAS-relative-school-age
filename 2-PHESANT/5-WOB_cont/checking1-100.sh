#!/bin/bash
for i in {1..100}
do
   echo "Array $i"
   grep BST slurm-10274439_${i}.out
done
