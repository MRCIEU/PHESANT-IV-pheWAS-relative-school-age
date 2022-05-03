saveCatUnordResult <- function(varName, varType, numNotNA, modelP, filename, params, fit) {
  
  sumx = summary(fit)
  cf = sumx$coefficients
#  params = colnames(cf)
  cats = rownames(cf)
  
  resLine = paste(varName, varType, numNotNA, modelP, paste(rep(NA, length(params)*4), collapse=','), sep=",")
  write(resLine, file=filename, append=TRUE)
  
  for (j in cats) {
    
    resLine = paste(paste0(varName, '#', j), varType, numNotNA, modelP, sep=",")
    
    for (i in 1:length(params)) {
      param = params[i]
      
      beta = cf[j, param]
      se = sumx$standard.errors[j, param]
      
      ci <- confint(fit, param, level=0.95)
      ci = data.frame(ci)
      ciL = ci[1, paste("X2.5...", j, sep="")]
      ciU =	ci[1, paste("X97.5...", j, sep="")]
      
      resForParam = paste(beta, ciL, ciU, se, sep=',')
      
      resLine = paste(resLine, resForParam, sep=',')
    }
    
    # append results line to file
    write(resLine, file=filename, append=TRUE)
    }
}


