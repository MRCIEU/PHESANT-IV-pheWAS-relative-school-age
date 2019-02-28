

# Searching for effect of month of birth

## 1. Generate our exposure data

Our exposure is a set of 11 indicator variables denoting the month of birth of each participant.

**** TBC



## 2. Phenotype (outcome) data

We use the PHESANT-derived data (derived using PHESANT v0.17) that was generated as part of a smoking MR-pheWAS [here](https://www.biorxiv.org/content/early/2018/10/19/441907).
The code available [here](https://github.com/MRCIEU/PHESANT-MR-pheWAS-smoking/tree/master/2-PHESANT/sample-all-save).


## 3. Run IV-pheWAS


Our IV-pheWAS generates a p-value for each outcome, using a likelihood ratio test of the regression model with the exposure variables, versus the regression model without the exposure variables 
(i.e. including only our covariates).

In the `jobs` directory:

```bash
qsub jp1-all.sh
```

**** TBC - update from test job to actual month data

