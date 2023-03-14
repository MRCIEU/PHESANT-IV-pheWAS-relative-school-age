

# IV-pheWAS of relative school age

We have conducted a hypothesis-free analysis, searching for the potential effects of relative school age.

## Environment details


The code uses some environment variables, which needs to be set in your linux environment.

I set the results directory and project data directory temporarily with:

```bash
export RES_DIR="${HOME}/2022SchoolAge/results"
export PROJECT_DATA="/mnt/storage/scratch/bo18534/SchoolAgeMiniProject/"
```


## 1. Data preparation

Prepare the exposure variables, and confounder file. The exposure variables are:

1. A binary variable of those born in August versus those born in September (i.e. restricting to participants born in these months).
2. A set of 11 indicator variables describing the month of birth of each participant.
3. Week of birth was used as continous exposure with the first week of September coded as 0 with 52 weeks in total. Dependent on the year of birth week 35 would fall into August (coded as week 52) or September (coded as week 0). 

See `1-data_preparation` directory.

Outcome data: We use the PHESANT-derived data (derived using PHESANT v0.17) that was generated as part of a smoking MR-pheWAS [here](https://www.biorxiv.org/content/early/2018/10/19/441907).
The code is available [here](https://github.com/MRCIEU/PHESANT-MR-pheWAS-smoking/tree/master/2-PHESANT/sample-all-save).


## 2. Run PHESANT

We run IV-pheWAS for the two instrumental variables described above. 
Our IV-pheWAS generates a p-value for each outcome, using a likelihood ratio test of the regression model with the exposure variables, versus the regression model without the exposure variables (i.e. including only our covariates).

See `2-PHESANT` directory.


## 3. Follow-up analyses

See `3-FollowUp directory.



