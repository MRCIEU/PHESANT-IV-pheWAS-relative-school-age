homedir = Sys.getenv('HOME')

library("data.table")

conf = fread(paste0(homedir,"/Phesant_ageatschool/data/confounder/variables_for_confounder.csv"), data.table=F)

colnames(conf) = c("eid","x31_0_0","x52_0_0","x54_0_0","x54_1_0","x54_2_0","x1647_1_0","x1647_2_0","x1647_3_0","x21022_0_0")
exp = conf[,c("eid","x52_0_0","x1647_1_0")]
head(exp)
nrow(exp)

#502616

exp_sub = subset(exp,((x52_0_0 == 8 | x52_0_0 == 9)&(x1647_1_0 == 1)))
head(exp_sub)
nrow(exp_sub)
#64096

exp_sub["Aug_Sep"] = NA

exp_sub$Aug_Sep[exp_sub$x52_0_0 == 8] = 0
head(exp_sub)

exp_sub$Aug_Sep[exp_sub$x52_0_0 == 9] = 1
head(exp_sub)

exp_fin = exp_sub[,c("eid","Aug_Sep")]
head(exp_fin)
write.csv(exp_fin, paste0(homedir,"/Phesant_ageatschool/data/exposure/exposure.csv"), row.names=F,quote=F)

# August = 0
# September = 1




exp_sub_1 = subset(exp,(x1647_1_0 == 1))
head(exp_sub_1)
nrow(exp_sub_1)
#390580

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
