saveCatOrdResult <- function(varName, varType, numNotNA, modelP, filename, params, fit) {
  
  sumx = summary(fit)  
  cf = sumx$coefficients  
  #params = rownames(cf)
  
  cis = confint(fit, level=0.95)
  
  resLine = paste(varName, varType, numNotNA, modelP, sep=",")
  
  for (i in 1:length(params)) {
    param = params[i]
    beta = cf[param, "Value"]
    se = cf[param, "Std. Error"]
    
    ciL = cis[param, "2.5 %"]
    ciU  =cis[param, "97.5 %"]
    
    resForParam = paste(beta, ciL, ciU, se, sep=',')
    
    resLine = paste(resLine, resForParam, sep=',')
  }
  
  # append results line to file
  write(resLine, file=filename, append=TRUE)
  
}

