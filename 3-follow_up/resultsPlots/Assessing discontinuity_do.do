* Assessing best fit of discontinuity

* Date started: 25/04/2023

* Author: Mel de Lange

****************************************************************************


log using SAExtra_log.log, replace



*Import data for exposures that passed the Boneferroni threshold for either  of our 2 exposures
import excel "thresholdsubset.xlsx", firstrow clear

*Open data browser
browse

*********************************************************************************
**Data preparation
*********************************************************************************
*Drop variable type, results for IVaug-sep and results for IVweeks
drop varTypex-varTypey
drop varType-se_week_new

*Destring the variables (data is in red, which tells us they are string variables)

ds n_IVmonths- se_Aug
foreach i in `r(varlist)'{
		destring `i',replace force 
}

*drop ci (as we're not using confidence intervals. *means everything beginning with ci)
drop ci*

*drop pvalue as we're not using it
drop pvalue_IVmonths

*Use the reshape command to turn the data into long format to use with metan and metareg
reshape long beta_ se_, i(varName) j(Month) string



*Reorder month number
gen Month_num=1 if Month=="Oct"
replace Month_num=2 if Month=="Nov"
replace Month_num=3 if Month=="Dec"
replace Month_num=4 if Month=="Jan"
replace Month_num=5 if Month=="Feb"
replace Month_num=6 if Month=="Mar"
replace Month_num=7 if Month=="Apr"
replace Month_num=8 if Month=="May"
replace Month_num=9 if Month=="Jun"
replace Month_num=10 if Month=="Jul"
replace Month_num=11 if Month=="Aug"

sort varName Month_num

*Generate new variable (VariableName) of actual variable names rather than numbers.


gen VariableName =  "Trouble concentrating on things in last 2 weeks" if varName == "X120110"
replace VariableName = "Comparative height size at age 10" if varName == "X1697"
replace VariableName = "Mood swings" if varName == "X1920"
replace VariableName = "Feelings easily hurt" if varName == "X1950"
replace VariableName = "Neuroticism score" if varName == "X20127"
replace VariableName = "Forced expiratory volume in 1-second (FEV1) Z-score" if varName == "X20256"
replace VariableName = "Year ended full time education" if varName == "X22501"
replace VariableName = "Job code of typist or transcriber" if varName == "X22601.42173304"
replace VariableName = "Year job started" if varName == "X22602"
replace VariableName = "Historical job code of typist" if varName == "X22617.4217"
replace VariableName = "Ever had bowel cancer screening" if varName == "X2345"
replace VariableName = "Mean MO in inferior cerebellar peduncle on FA skeleton (left)" if varName == "X25163"
replace VariableName = "Mean MO in tapetum on FA skeleton (right)" if varName == "X25198"
replace VariableName = "Mean OD in tapetum on FA skeleton (right)" if varName == "X25438"
replace VariableName = "Age started smoking in former smokers" if varName == "X2867"
replace VariableName = "3mm asymmetry angle (right)" if varName == "X5108"
replace VariableName = "Have college or university degree" if varName == "X6138.1"
replace VariableName = "Have A levels or AS levels or equivalent " if varName == "X6138.2"
replace VariableName = "Have O levels or GCSEs or equivalent" if varName == "X6138.3"
replace VariableName = "Have CSEs or equivalent" if varName == "X6138.4"
replace VariableName = "Age completed full time education" if varName == "X845"

*Drop X20127 as this doesn't have data in & stops the loop working.
drop if varName=="X20127"

*******************************************************************************************************************
*Data analysis
*******************************************************************************************************************
*Part 1:Metan Graphs
*Loop to meta-analyse and save all the graphs

*Code to save graphs normally
levels VariableName
foreach i in `r(levels)'{
		metan beta_ se_ if VariableName =="`i'", lcols(Month) xtitle(Beta coefficient) graphregion(color(white)) bgcolor(white) 
		graph save "file_`i'", replace
		}	

*Code to do the same but save graphs as high quality version (windows metafile) to be added to word/powerpoint.	
*To paste into word do - insert - picture.
	levels VariableName
foreach i in `r(levels)'{
		metan beta_ se_ if VariableName =="`i'", lcols(Month) xtitle("Beta coefficient", size(small)) graphregion(color(white)) bgcolor(white) 
		graph export "file_`i'.wmf", replace
		}		
		
***********************************************************************************
*Part 2:First Metareg
		
*Run meta regression for one exposure to set up saving file.
metareg beta_ Month_num if VariableName =="Trouble concentrating on things in last 2 weeks" ,wsse(se_ )		
regsave Month_num using "results", pval detail(all) replace 			
		
*Next run meta regression on the month ordinal variable		
levels VariableName
foreach i in `r(levels)'{
	di "`i'"
	metareg beta_ Month_num if VariableName =="`i'" ,wsse(se_ )		
	regsave Month_num using "results", pval detail(all) append addlabel(pheno,"`i'") 
	}


	
*************************************************************************************************
*Part 3
	
*Set up saving file
metareg beta_ Month_num if VariableName =="Trouble concentrating on things in last 2 weeks" ,wsse(se_ )		
regsave Month_num using "results_dummy_linear", pval detail(all) replace 
	

*Generate Month_num2 variable	
gen Month_num2=Month_num

*Run meta regression for all exposures starting at each of the 11 months.
levels VariableName
foreach j in `r(levels)'{
replace Month_num=Month_num2
forvalues i =1(1)11{
	metareg beta_ Month_num if VariableName =="`j'" ,wsse(se_ )		
	regsave Month_num using "results_dummy_linear", pval detail(all) append  addlabel(var2, "`j'", Month, `i')
	
	replace Month_num=Month_num+1 
	replace Month_num=1 if Month_num==12
	}
	}


	*Save results as excel files:
use results, clear
	export excel "results.xlsx", firstrow(varlabels) replace
	
use results_dummy_linear, clear	
export excel "results_dummy_linear.xlsx", firstrow(varlabels) replace

**Close log
log close
