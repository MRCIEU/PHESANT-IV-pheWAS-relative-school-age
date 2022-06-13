resDir = Sys.getenv("RES_DIR")
library("ggplot2")

exp2_data<-read.delim(paste(resDir,'/phesant/exposure2/allres.csv', sep=""), sep=',', header=1)
head(exp2_data)


numrows <- nrow(exp2_data)
print(numrows)

for (i in 1:numrows){
  varName <- exp2_data[i,"varName"]

Month <- c("Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Oct", "Nov", "Dec")
Beta <- c(exp2_data[i,"beta_Jan"],exp2_data[i,"beta_Feb"], exp2_data[i,"beta_Mar"], exp2_data[i,"beta_Apr"], exp2_data[i,"beta_May"], exp2_data[i,"beta_Jun"], exp2_data[i,"beta_Jul"], exp2_data[i,"beta_Aug"], exp2_data[i,"beta_Oct"], exp2_data[i,"beta_Nov"], exp2_data[i,"beta_Dec"] )
lowci <-c(exp2_data[i,"ciL_Jan"],exp2_data[i,"ciL_Feb"], exp2_data[i,"ciL_Mar"], exp2_data[i,"ciL_Apr"], exp2_data[i,"ciL_May"], exp2_data[i,"ciL_Jun"], exp2_data[i,"ciL_Jul"], exp2_data[i,"ciL_Aug"], exp2_data[i,"ciL_Oct"], exp2_data[i,"ciL_Nov"], exp2_data[i,"ciL_Dec"])
upci <- c(exp2_data[i,"ciU_Jan"],exp2_data[i,"ciU_Feb"], exp2_data[i,"ciU_Mar"], exp2_data[i,"ciU_Apr"], exp2_data[i,"ciU_May"], exp2_data[i,"ciU_Jun"], exp2_data[i,"ciU_Jul"], exp2_data[i,"ciU_Aug"], exp2_data[i,"ciU_Oct"], exp2_data[i,"ciU_Nov"], exp2_data[i,"ciU_Dec"])
    
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
  


