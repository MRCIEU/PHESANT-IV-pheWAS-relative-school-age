homedir = Sys.getenv('HOME')

library("data.table")

conf = fread(paste0(homedir,"/Phesant_ageatschool/data/confounder/variables_for_confounder.csv"), data.table=F)

colnames(conf) = c("eid","x31_0_0","x52_0_0","x54_0_0","x54_1_0","x54_2_0","x1647_1_0","x1647_2_0","x1647_3_0","x21022_0_0")
exp = conf[,c("eid","x52_0_0","x1647_1_0")]
head(exp)
nrow(exp)

#502616


## Restrict to participants born in England in August or September

exp_sub = subset(exp,((x52_0_0 == 8 | x52_0_0 == 9)&(x1647_1_0 == 1)))
head(exp_sub)
nrow(exp_sub)

#64096 participants


## Dummy variables for bron in August (0) or September (1)  - Exposure 1

exp_sub["Aug_Sep"] = NA

exp_sub$Aug_Sep[exp_sub$x52_0_0 == 8] = 0
head(exp_sub)

exp_sub$Aug_Sep[exp_sub$x52_0_0 == 9] = 1
head(exp_sub)

exp_fin = exp_sub[,c("eid","Aug_Sep")]
head(exp_fin)
write.csv(exp_fin, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure.csv"), row.names=F,quote=F)




## Restrict to participants born in England

exp_sub_1 = subset(exp,(x1647_1_0 == 1))
head(exp_sub_1)
nrow(exp_sub_1)

#390580 participants

## Dummy variable for each month startin with September (0)  - Exposure 2

exp_sub_1["recode_month"] = NA

exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 9] = 0
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 10] = 1
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 11] = 2
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 12] = 3
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 1] = 4
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 2] = 5
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 3] = 6
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 4] = 7
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 5] = 8
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 6] = 9
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 7] = 10
exp_sub_1$recode_month[exp_sub_1$x52_0_0 == 8] = 11

head(exp_sub_1)

exp_fin_1 = exp_sub_1[,c("eid","recode_month")]
head(exp_fin_1)
write.csv(exp_fin_1, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure_1.csv"), row.names=F,quote=F)


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



