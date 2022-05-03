saveHeader <- function(filename, params) {
  
  resLine = "varName,varType,n,pvalue"
  
  for (i in 1:length(params)) {
    param = params[i]
    
    resForParam = paste(paste0('beta_', param), paste0('ciL_', param), paste0('ciU_', param), paste0('se_', param), sep=',')
    
    resLine = paste(resLine, resForParam, sep=',')
  }
  
  # append results line to file
  write(resLine, file=filename, append=FALSE)
  
}
