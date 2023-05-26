




## Add results descriptions

Add description of fields to results CSV. This is run locally so not in a blue crystal job.


```bash
Rscript addPHESANTDescriptions.r
```

## Combining results from the different IV-phewAS

This combines the results of the three IV-pheWAS into one results table.


```bash
Rscript combineresults.r
```


## Threshold results

This limits the combined results table to just those phenotypes that passed the Bonferroni threshold for Sept vs Aug and week of birth IVs.


```bash
Rscript thresholdresults.r
```

