#!/bin/bash
for i in {101..200}
do
   echo "Array $i"
   grep BST slurm-10508551_${i}.out
done
