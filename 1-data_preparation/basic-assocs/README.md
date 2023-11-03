# basic associations to check IV assumptions

sex: field ID 31
year of birth: field ID 34
birth weight: field ID 20022
UKB assessment centre (location proxy): field ID 54


## Extract fields from large data file

Find the column indexes for these fields:

```bash
head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'eid'
head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x31_0'
head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x34_0'
head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x20022_0'
head -n 1 ${PROJECT_DATA}/Original/data.48196.phesant.csv | sed 's/,/\n/g' | cat -n | grep 'x54_0'
```


Extract the columns we need:

```bash
cut -d, -f1,11,12,7193,46 ${PROJECT_DATA}/Original/data.48196.phesant.csv > ${PROJECT_DATA}/Derived/basic-assoc-vars.csv
```


## Run associations

Run R script to test associations (interactively on blue crystal):

```bash
Rscript test_assocs.R
```

