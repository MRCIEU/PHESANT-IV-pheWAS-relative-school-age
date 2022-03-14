# DATA PREPARATION

## 1. Extract Phenotypes

Run exposure/confounder extraction on Blue Crystal Phase 4.

```bash
sbatch 1-extract_Exp_Conf.sh
```

##2. Restrict sample to those born in England.

See ```restrict_sample.r```

##3. Create Confounders file.

Includes age and sex.
See ```make_confounder.r```

##4. Create Exposure files.

1. A binary variable of those born in August versus those born in September (i.e. restricting to participants born in these months) (with September coded as 1 and August as 0)
2. A set of 11 indicator variables describing the month of birth of each participant (with September as baseline).
3. Week of birth as a continuous variable with the first week of September coded as 0 with 52 weeks in total. Dependent on the year of birth week 35 would fall into August (coded as week 52) or September (coded as week 0).
See ```make_exposure.r```
