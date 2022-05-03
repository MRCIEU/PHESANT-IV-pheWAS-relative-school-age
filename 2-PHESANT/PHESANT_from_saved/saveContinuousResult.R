saveContinuousResult <- function(varName, varType, numNotNA, modelP, filename, params, fit) {
  
  
  cf <-coef(summary(fit,complete = TRUE)) 
  #params = rownames(cf)
  cis = confint(fit, level=0.95)
  
  resLine = paste(varName, varType, numNotNA, modelP, sep=",")
  
  for (i in 1:length(params)) {
    param = params[i]
    print(param)
    beta = cf[param, "Estimate"]
    se = cf[param, "Std. Error"]
    ciL = cis[param, "2.5 %"]
    ciU = cis[param, "97.5 %"]
    resForParam = paste(beta, ciL, ciU, se, sep=',')
    
    resLine = paste(resLine, resForParam, sep=',')
  }
 
  # append results line to file
  write(resLine, file=filename, append=TRUE)
  
}

