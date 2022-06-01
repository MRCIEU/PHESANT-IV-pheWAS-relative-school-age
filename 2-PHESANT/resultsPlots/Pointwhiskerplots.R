setwd("C:/Users/bo18534/OneDrive - University of Bristol/School age mini project/Results")
library("ggplot2")

notepad_data <- read.table("notepadtest.csv", header = TRUE, sep= ",")
head(notepad_data)


numrows <- nrow(notepad_data)
print(numrows)

for (i in 1:numrows){
  varName <- notepad_data[i,"varName"]
  
  Month <- c("Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Oct", "Nov", "Dec")
  Beta <- c(notepad_data[i,"beta_Jan"],notepad_data[i,"beta_Feb"], notepad_data[i,"beta_Mar"], notepad_data[i,"beta_Apr"], notepad_data[i,"beta_May"], notepad_data[i,"beta_Jun"], notepad_data[i,"beta_Jul"], notepad_data[i,"beta_Aug"], notepad_data[i,"beta_Oct"], notepad_data[i,"beta_Nov"], notepad_data[i,"beta_Dec"] )
  lowci <-c(notepad_data[i,"ciL_Jan"],notepad_data[i,"ciL_Feb"], notepad_data[i,"ciL_Mar"], notepad_data[i,"ciL_Apr"], notepad_data[i,"ciL_May"], notepad_data[i,"ciL_Jun"], notepad_data[i,"ciL_Jul"], notepad_data[i,"ciL_Aug"], notepad_data[i,"ciL_Oct"], notepad_data[i,"ciL_Nov"], notepad_data[i,"ciL_Dec"])
  upci <- c(notepad_data[i,"ciU_Jan"],notepad_data[i,"ciU_Feb"], notepad_data[i,"ciU_Mar"], notepad_data[i,"ciU_Apr"], notepad_data[i,"ciU_May"], notepad_data[i,"ciU_Jun"], notepad_data[i,"ciU_Jul"], notepad_data[i,"ciU_Aug"], notepad_data[i,"ciU_Oct"], notepad_data[i,"ciU_Nov"], notepad_data[i,"ciU_Dec"])
  
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
  


