#!/bin/bash
for i in {149,153,160}
do
   echo "Array $i"
   grep BST slurm-10191863_${i}.out
done

