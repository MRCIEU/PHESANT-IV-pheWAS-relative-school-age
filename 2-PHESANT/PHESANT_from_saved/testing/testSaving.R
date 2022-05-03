
setwd('..')

## save header test

params = c('x1', 'x2')
source('saveHeader.R')
saveHeader('test.csv', params)




## continuous test

n=1000
x1 = rnorm(n)
x2 = rnorm(n)

xs = data.frame(x1=x1, x2=x2)
y = 2*x1+3*x2 + rnorm(n)

fit <- lm(y ~ ., data=xs)


source('saveContinuousResult.R')
saveContinuousResult('test1', 'cont', 1000, 0.0001, 'test.csv', params, fit)



## binary test

ybin = rep(0, 1000)
ybin[which(y>0)]=1
mylogit <- glm(ybin ~ ., data=xs)

source('saveBinaryResult.R')
saveBinaryResult('test1', 'bin', 1000, 0.01, 'test.csv', params, mylogit)



## unordered cat test
ycat = rep(0, 1000)
ycat[which(y>0)]=1
ycat[which(y>0.5)]=2

require(nnet)
fit <- multinom(ycat ~  ., data=xs, maxit=1000)

source('saveCatUnordResult.R')
saveCatUnordResult('test1', 'cat-unord', 1000, 0.01, 'test.csv', params, fit)


## Cat ordered test

require(MASS)
require(lmtest)
fit <- polr(as.factor(ycat) ~  ., data=xs, Hess=TRUE)

source('saveCatOrdResult.R')
saveCatOrdResult('test1', 'cat-ord', 1000, 0.01, 'test.csv', params, fit)




