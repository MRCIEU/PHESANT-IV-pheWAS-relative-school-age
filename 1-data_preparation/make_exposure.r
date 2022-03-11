dataDir = Sys.getenv("PROJECT_DATA")

##Generate exposure file for 3 exposure variables

exposures = read.table(paste(dataDir,'/Derived/exposure_confounder_variables_subset.csv', sep=""), sep=',', header=1)


##Instrumental variable 1: month of birth (x52)
exposures = exposures[,c("eid","x52_0_0")]
head(exposures)
nrow(exposures)

#390,454

#################################################################################################

##Exposure 1: Binary variable born in August vs September
#Restrict to participants born in August or September
exposure1_sub = subset(exposures,(x52_0_0 == 8 | x52_0_0 == 9))
head(exposure1_sub)
nrow(exposure1_sub)

#64,081 participants

#Create Dummy variables for born in September (1) or August (0)
exposure1_sub$Sep_Aug = ifelse(exposure1_sub$x52_0_0 == 9, 1, 0)


exposure1_sub = exposure1_sub[,c("eid","Sep_Aug")]
head(exposure1_sub)

write.table(exposure1_sub, paste(dataDir,'/Derived/exposure1-Sep_Aug.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)

#######################################################################################################

##Exposure 2: Categorical variable of month of birth (sept=0 to aug=11)

head(exposures)

exposures["recode_month"] = NA
exposures$recode_month[exposures$x52_0_0 == 9] = 0
exposures$recode_month[exposures$x52_0_0 == 10] = 1
exposures$recode_month[exposures$x52_0_0 == 11] = 2
exposures$recode_month[exposures$x52_0_0 == 12] = 3
exposures$recode_month[exposures$x52_0_0 == 1] = 4
exposures$recode_month[exposures$x52_0_0 == 2] = 5
exposures$recode_month[exposures$x52_0_0 == 3] = 6
exposures$recode_month[exposures$x52_0_0 == 4] = 7
exposures$recode_month[exposures$x52_0_0 == 5] = 8
exposures$recode_month[exposures$x52_0_0 == 6] = 9
exposures$recode_month[exposures$x52_0_0 == 7] = 10
exposures$recode_month[exposures$x52_0_0 == 8] = 11

head(exposures)
exposure2 = exposures[,c("eid","recode_month")]
head(exposure2)
write.table(exposure2, paste(dataDir,'/Derived/exposure2-months0-11.csv',sep=""), sep=',', row.names=FALSE, quote = FALSE)


## Exposure file with Dummy variables for each month

exp_sub_2 = exp_sub_1
exp_sub_2["Oct"]= 0
exp_sub_2["Nov"]= 0
exp_sub_2["Dec"]= 0
exp_sub_2["Jan"]= 0
exp_sub_2["Feb"]= 0
exp_sub_2["Mar"]= 0
exp_sub_2["Apr"]= 0
exp_sub_2["May"]= 0
exp_sub_2["Jun"]= 0
exp_sub_2["Jul"]= 0
exp_sub_2["Aug"]= 0

exp_sub_2$Oct[exp_sub_2$x52_0_0 == 10] = 1
exp_sub_2$Nov[exp_sub_2$x52_0_0 == 11] = 1
exp_sub_2$Dec[exp_sub_2$x52_0_0 == 12] = 1
exp_sub_2$Jan[exp_sub_2$x52_0_0 == 1] = 1
exp_sub_2$Feb[exp_sub_2$x52_0_0 == 2] = 1
exp_sub_2$Mar[exp_sub_2$x52_0_0 == 3] = 1
exp_sub_2$Apr[exp_sub_2$x52_0_0 == 4] = 1
exp_sub_2$May[exp_sub_2$x52_0_0 == 5] = 1
exp_sub_2$Jun[exp_sub_2$x52_0_0 == 6] = 1
exp_sub_2$Jul[exp_sub_2$x52_0_0 == 7] = 1
exp_sub_2$Aug[exp_sub_2$x52_0_0 == 8] = 1

exp_sub_2$Oct[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Nov[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Dec[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Jan[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Feb[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Mar[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Apr[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$May[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Jun[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Jul[exp_sub_2$x52_0_0 == NA] = NA
exp_sub_2$Aug[exp_sub_2$x52_0_0 == NA] = NA


exp_fin_2 = exp_sub_2[,c("eid","Oct","Nov","Dec","Jan","Feb","Mar","May","Jun","Jul","Aug")]
head(exp_fin_2)
write.csv(exp_fin_2, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure_2.csv"), row.names=F,quote=F)

#######################################################
## Week of Birth #####################################

# For August - Spetember births 

wob = read.csv(paste0(wobdir,"/app_16729_wob.csv"))
head(wob)

wob_exp = merge(exp_fin, wob, keep.all=TRUE)
wob_exp = wob_exp[order(wob_exp$week),]
unique(wob_exp$week)

#31 32 33 34 35 36 37 38 39

wob_fin = wob_exp[,c(1,3)]
write.csv(wob_fin, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure_wob_1.csv"), row.names=F,quote=F)

# Continious for all

wob_cont = merge(exp_fin_1, wob, keep.all=TRUE)
wob_cont = wob_cont[order(wob_cont$week),]
wob_cont = wob_cont[order(wob_cont$recode_month),]

wob_cont["week_new"] = wob_cont$week

wob_cont$week_new[wob_cont$week == 35 & wob_cont$recode_month == 0] = 0
wob_cont$week_new[wob_cont$week == 35 & wob_cont$recode_month == 11] = 52

wob_cont$week_new =recode(wob_cont$week_new,"36=1;37=2;38=3;39=4;40=5;41=6;42=7;43=8;44=9;45=10;46=11;47=12;48=13;49=14;50=15;51=16;52=17;1=18;2=19;3=20;4=21;5=22;6=23;7=24;8=25;9=26;10=27;11=28;12=29;13=30;14=31;15=32;16=33;17=34;18=35;19=36;20=37;21=38;22=39;23=40;24=41;25=42;26=43;27=44;28=45;29=46;30=47;31=48;32=49;33=50;34=51")

wob_cont_fin = wob_cont[,c(1,4)]
write.csv(wob_cont_fin, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure_wob_2.csv"), row.names=F,quote=F)
