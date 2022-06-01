#!/bin/bash
for i in {149,153,160}
do
   echo "Array $i"
   grep BST slurm-10426295_${i}.out
done

