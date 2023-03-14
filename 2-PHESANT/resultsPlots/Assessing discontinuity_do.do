* Assessing best fit of discontinuity

* Date started: 02/12/2022

* Author: Mel de Lange

****************************************************************************


log using SAMetareg1_log.log

*Import data for exposures that passed the Boneferroni threshold for any of our 3 exposures
import excel "thresholdsubset_exp2data.xlsx", firstrow clear

*Open data browser
browse

*********************************************************************************
**Data preparation
*********************************************************************************
	

*Destring the variables (data is in red, which tells us they are string variables)

ds n_exp2- se_Aug
foreach i in `r(varlist)'{
		destring `i',replace force 
}

*drop ci (as we're not using confidence intervals. *means everything beginning with ci)
drop ci*

*Use the reshape command to turn the data into long format to use with metan and metareg
reshape long beta_ se_, i(varName) j(month) string

*drop pvalue as we're not using it
drop pvalue_exp2

*Reorder month number
gen month_num=1 if month=="Oct"
replace month_num=2 if month=="Nov"
replace month_num=3 if month=="Dec"
replace month_num=4 if month=="Jan"
replace month_num=5 if month=="Feb"
replace month_num=6 if month=="Mar"
replace month_num=7 if month=="Apr"
replace month_num=8 if month=="May"
replace month_num=9 if month=="Jun"
replace month_num=10 if month=="Jul"
replace month_num=11 if month=="Aug"

sort varName month_num

*Generate new variable (VariableName) of actual variable names rather than numbers.

gen VariableName = "Ease of getting up in the morning" if varName == "X1170"
replace VariableName = "Trouble concentrating on things in last 2 weeks" if varName == "X120110"
replace VariableName = "Whether breastfed as a baby" if varName == "X1677"
replace VariableName = "Comparative body size at age 10" if varName == "X1687"
replace VariableName = "Comparative height size at age 10" if varName == "X1697"
replace VariableName = "Mood swings" if varName == "X1920"
replace VariableName = "Feelings easily hurt" if varName == "X1950"
replace VariableName = "Describe self as nervous person" if varName == "X1970"
replace VariableName = "Describe self as a worrier" if varName == "X1980"
replace VariableName = "Birth weight" if varName == "X20022"
replace VariableName = "Neuroticism score" if varName == "X20127"
replace VariableName = "Forced expiratory volume in 1-second (FEV1) Z-score" if varName == "X20256"
replace VariableName = "Describe self as risk taker" if varName == "X2040"
replace VariableName = "Year ended full time education" if varName == "X22501"
replace VariableName = "Job code of typist or transcriber" if varName == "X22601.42173304"
replace VariableName = "Year job started" if varName == "X22602"
replace VariableName = "Historical job code of typist" if varName == "X22617.4217"
replace VariableName = "Whole body fat-free mass" if varName == "X23101"
replace VariableName = "Whole body water mass" if varName == "X23102"
replace VariableName = "Whole body impedence" if varName == "X23106"
replace VariableName = "Impedence of right leg" if varName == "X23107"
replace VariableName = "Impedence of left leg" if varName == "X23108"
replace VariableName = "Fat-free mass of right leg" if varName == "X23113"
replace VariableName = "Predicted mass of right leg" if varName == "X23114"
replace VariableName = "Fat-free mass of left leg" if varName == "X23117"
replace VariableName = "Predicted mass of left leg" if varName == "X23118"
replace VariableName = "Ever had bowel cancer screening" if varName == "X2345"
replace VariableName = "Mean MO in inferior cerebellar peduncle on FA skeleton (left)" if varName == "X25163"
replace VariableName = "Mean MO in tapetum on FA skeleton (right)" if varName == "X25198"
replace VariableName = "Mean OD in posterior thalamic radiation on FA skeleton (right)" if varName == "X25420"
replace VariableName = "Mean OD in tapetum on FA skeleton (right)" if varName == "X25438"
replace VariableName = "Ever had breast cancer screening or mammogram" if varName == "X2674"
replace VariableName = "Age started smoking in former smokers" if varName == "X2867"
replace VariableName = "Standing height" if varName == "X50"
replace VariableName = "3mm weak meridian (left)" if varName == "X5096"
replace VariableName = "6mm weak meridian (left)" if varName == "X5097"
replace VariableName = "6mm weak meridian (right)" if varName == "X5098"
replace VariableName = "3mm weak meridian (right)" if varName == "X5099"
replace VariableName = "3mm strong meridian angle (left)" if varName == "X5104"
replace VariableName = "3mm asymmetry angle (right)" if varName == "X5108"
replace VariableName = "6mm asymmetry angle (left)" if varName == "X5110"
replace VariableName = "3mm asymmetry angle (left)" if varName == "X5111"
replace VariableName = "3mm cylindrical power (right)" if varName == "X5116"
replace VariableName = "3mm cylindrical power (left)" if varName == "X5119"
replace VariableName = "3mm strong meridian (right)" if varName == "X5132"
replace VariableName = "6mm strong meridian (right)" if varName == "X5133"
replace VariableName = "6mm strong meridian (left)" if varName == "X5134"
replace VariableName = "3mm strong meridian (left)" if varName == "X5135"
replace VariableName = "logMAR, final (right)" if varName == "X5201"
replace VariableName = "logMAR, final (left)" if varName == "X5208"
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
*Loop to meta-analyse and save all the graphs as pdfs

levels VariableName
foreach i in `r(levels)'{
		metan beta_ se_ if VariableName =="`i'", lcols(month)
		graph save "file_`i'", replace
		}	

*Code to do the same but save graphs as pdf
*levels VariableName
*foreach i in `r(levels)'{
		*metan beta_ se_ if VariableName =="`i'", lcols(month)
		*graph export "file_`i'.pdf", replace
		*}
		
***********************************************************************************
*Part 2:First Metareg

		
*Run meta regression for one exposure to set up saving file.
metareg beta_ month_num if VariableName =="Ease of getting up in the morning" ,wsse(se_ )		
regsave month_num using "results", detail(all) replace 		
		
*Next run meta regression on the month ordinal variable		
levels VariableName
foreach i in `r(levels)'{
	di "`i'"
	metareg beta_ month_num if VariableName =="`i'" ,wsse(se_ )		
	regsave month_num using "results", detail(all) append addlabel(pheno,"`i'") 
	}

	
*************************************************************************************************
*Part 3
	
*Set up saving file
metareg beta_ month_num if VariableName =="Ease of getting up in the morning" ,wsse(se_ )		
regsave month_num using "results_dummy_linear", detail(all) replace 
	

*Generate month_num2 variable	
gen month_num2=month_num

*Run meta regression for all exposures starting at each of the 11 months.
levels VariableName
foreach j in `r(levels)'{
replace month_num=month_num2
forvalues i =1(1)11{
	metareg beta_ month_num if VariableName =="`j'" ,wsse(se_ )		
	regsave month_num using "results_dummy_linear", detail(all) append  addlabel(var2, "`j'", month, `i')
	
	replace month_num=month_num+1 
	replace month_num=1 if month_num==12
	}
	}
	
	use results, clear
	export excel "results.xlsx", firstrow(varlabels) replace
	
use results_dummy_linear, clear
export excel "results_dummy_linear.xlsx", firstrow(varlabels) replace