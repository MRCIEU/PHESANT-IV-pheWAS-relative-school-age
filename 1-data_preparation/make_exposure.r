dataDir = Sys.getenv("PROJECT_DATA")

##Generate exposure file for 3 exposure variables

exposures = read.table(paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv', sep=""), sep=',', header=1)


##Instrumental variable 1: month of birth (x52)
exposures = exposures[,c("eid","x52_0_0")]
head(exposures)
nrow(exposures)

#390,427

#################################################################################################

##Exposure 1: Binary variable born in August vs September
#Restrict to participants born in August or September
exposure1_sub = subset(exposures,(x52_0_0 == 8 | x52_0_0 == 9))
head(exposure1_sub)
nrow(exposure1_sub)

#64,075 participants

#Create Dummy variables for born in September (1) or August (0)
exposure1_sub$Sep_Aug = ifelse(exposure1_sub$x52_0_0 == 9, 1, 0)


exposure1_sub = exposure1_sub[,c("eid","Sep_Aug")]
head(exposure1_sub)

write.table(exposure1_sub, paste(dataDir,'/Derived/exposure1-Sep_Aug.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

#######################################################################################################

##Exposure 2:11 indicator variables for each month of birth (excluding September)


exposures["Oct"]= 0
exposures["Nov"]= 0
exposures["Dec"]= 0
exposures["Jan"]= 0
exposures["Feb"]= 0
exposures["Mar"]= 0
exposures["Apr"]= 0
exposures["May"]= 0
exposures["Jun"]= 0
exposures["Jul"]= 0
exposures["Aug"]= 0
head(exposures)

exposures$Oct[exposures$x52_0_0 == 10] = 1
exposures$Nov[exposures$x52_0_0 == 11] = 1
exposures$Dec[exposures$x52_0_0 == 12] = 1
exposures$Jan[exposures$x52_0_0 == 1] = 1
exposures$Feb[exposures$x52_0_0 == 2] = 1
exposures$Mar[exposures$x52_0_0 == 3] = 1
exposures$Apr[exposures$x52_0_0 == 4] = 1
exposures$May[exposures$x52_0_0 == 5] = 1
exposures$Jun[exposures$x52_0_0 == 6] = 1
exposures$Jul[exposures$x52_0_0 == 7] = 1
exposures$Aug[exposures$x52_0_0 == 8] = 1

exposures$Oct[exposures$x52_0_0 == NA] = NA
exposures$Nov[exposures$x52_0_0 == NA] = NA
exposures$Dec[exposures$x52_0_0 == NA] = NA
exposures$Jan[exposures$x52_0_0 == NA] = NA
exposures$Feb[exposures$x52_0_0 == NA] = NA
exposures$Mar[exposures$x52_0_0 == NA] = NA
exposures$Apr[exposures$x52_0_0 == NA] = NA
exposures$May[exposures$x52_0_0 == NA] = NA
exposures$Jun[exposures$x52_0_0 == NA] = NA
exposures$Jul[exposures$x52_0_0 == NA] = NA
exposures$Aug[exposures$x52_0_0 == NA] = NA

head(exposures)
exposure2 = exposures [,c("eid","Oct","Nov","Dec","Jan","Feb","Mar","May","Jun","Jul","Aug")]
head(exposure2)
write.table(exposure2, paste(dataDir,'/Derived/exposure2_month_indicator_variables.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)


################################################################################################
#Instrumental variable 2: Week of birth

#Exposure 3: Week of birth (continuous)

library(dplyr)

wob = read.table(paste(dataDir,'/Original/app_16729_wob.csv', sep=""), sep=',', header=1) 
head(wob)
nrow(wob)

#Remove cases which fall in week 35 (includes the 31st August & 1st September)
wob = subset(wob, week != 35)
head(wob)
nrow(wob)

#Recode weeks so that week 36 (beginning of September = 1)
wob$week_new =recode(wob$week,'36'=1, '37'=2, '38'=3, '39'=4, '40'=5, '41'=6, '42'=7, '43'=8, '44'=9, '45'=10, '46'=11, '47'=12, '48'=13, '49'=14, '50'=15, '51'=16, '52'=17, '1'=18, '2'=19, '3'=20, '4'=21, '5'=22, '6'=23, '7'=24, '8'=25, '9'=26, '10'=27, '11'=28, '12'=29, '13'=30, '14'=31, '15'=32, '16'=33, '17'=34, '18'=35, '19'=36, '20'=37, '21'=38, '22'=39, '23'=40, '24'=41, '25'=42, '26'=43, '27'=44, '28'=45, '29'=46, '30'=47, '31'=48, '32'=49, '33'=50, '34'=51)

#Order according to week of birth
wob = wob[order(wob$week_new),]
head(wob)

#Drop original 'week' column so just have eid and week_new
wob = wob[,c("eid","week_new")]
head(wob)

write.table(wob, paste(dataDir,'/Derived/exposure3-wob.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)











