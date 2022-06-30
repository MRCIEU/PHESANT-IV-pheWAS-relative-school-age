#!/bin/bash
for i in {10}
do
   echo "Array $i"
   grep BST slurm-10508110_${i}.out
done

