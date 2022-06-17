resDir = Sys.getenv("RES_DIR")
library("ggplot2")

threshsub<-read.delim(paste(resDir,'/phesant/thresholdsubset.csv', sep=""), sep=',', header=1)
head(threshsub)

numrows <- nrow(threshsub)
print(numrows)

setwd(Sys.getenv("RES_DIR"))

for (i in 1:numrows){
  varName <- threshsub[i,"varName"]

Month <- c("Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Oct", "Nov", "Dec")
Beta <- c(threshsub[i,"beta_Jan"],threshsub[i,"beta_Feb"], threshsub[i,"beta_Mar"], threshsub[i,"beta_Apr"], threshsub[i,"beta_May"], threshsub[i,"beta_Jun"], threshsub[i,"beta_Jul"], threshsub[i,"beta_Aug"], threshsub[i,"beta_Oct"], threshsub[i,"beta_Nov"], threshsub[i,"beta_Dec"] )
lowci <-c(threshsub[i,"ciL_Jan"],threshsub[i,"ciL_Feb"], threshsub[i,"ciL_Mar"], threshsub[i,"ciL_Apr"], threshsub[i,"ciL_May"], threshsub[i,"ciL_Jun"], threshsub[i,"ciL_Jul"], threshsub[i,"ciL_Aug"], threshsub[i,"ciL_Oct"], threshsub[i,"ciL_Nov"], threshsub[i,"ciL_Dec"])
upci <- c(threshsub[i,"ciU_Jan"],threshsub[i,"ciU_Feb"], threshsub[i,"ciU_Mar"], threshsub[i,"ciU_Apr"], threshsub[i,"ciU_May"], threshsub[i,"ciU_Jun"], threshsub[i,"ciU_Jul"], threshsub[i,"ciU_Aug"], threshsub[i,"ciU_Oct"], threshsub[i,"ciU_Nov"], threshsub[i,"ciU_Dec"])

    
  df <-data.frame(Month, Beta, lowci, upci)
  print(df)
  
  data_plot <- ggplot(df, aes(Month, Beta)) +        # ggplot2 plot with confidence intervals
    geom_point() +
    geom_errorbar(aes(ymin = lowci, ymax = upci))
  
  data_plot +
    scale_x_discrete(limits = Month) +
    labs(title =paste("Plot",varName))+
           labs(y = "Beta (97.5% CIs)")
  
  ggsave(paste0("Plot",varName,".pdf"))
}
  


