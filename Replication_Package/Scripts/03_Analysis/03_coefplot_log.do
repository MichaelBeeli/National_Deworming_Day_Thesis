// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Simple Coefplot for Logistic Regression Model





preserve 

keep if agegroup == "5-10"

svy: quietly logit three_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo read_log_5: margins, dydx(treat_post) at(treat == 1 post == 1) post


svy: quietly logit three_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo math_log_5: margins, dydx(treat_post) at(treat == 1 post == 1) post


svy: quietly  logit  three_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo english_log_5: margins, dydx(treat_post) at(treat == 1 post == 1) post


restore


preserve 

keep if agegroup == "11-16"


svy: quietly logit four_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo read_log_11: margins, dydx(treat_post) at(treat == 1 post == 1) post


svy: quietly logit four_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo math_log_11: margins, dydx(treat_post) at(treat == 1 post == 1) post


svy: quietly  logit  four_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

quietly eststo english_log_11: margins, dydx(treat_post) at(treat == 1 post == 1) post


restore


coefplot ///
	(read_log_5, label("Reading Score (5-10)") ciopts(recast(. rcap) color(cranberry cranberry)) mlabcolor(cranberry) mcolor(cranberry) ) ///
	(math_log_5, label("Math Score (5-10)")ciopts(recast(. rcap) color(navy navy)) mlabcolor(navy) mcolor(navy)) ///
	 (english_log_5, label("English Score (5-10)")ciopts(recast(. rcap) color(forest_green forest_green) mcolor(forest_green)) mlabcolor(forest_green)) ///
	 (read_log_11, label("Reading Score (11-16)") ciopts(recast(. rcap) color(red red)) mcolor(red) mlabcolor(red)) ///
	 (math_log_11, label("Math Score (11-16)")ciopts(recast(. rcap) color(ebblue ebblue)) mcolor(ebblue) mlabcolor(ebblue)) ///
	 (english_log_11, label("English Score (11-16)")ciopts(recast(. rcap) color(green green)) mcolor(green) mlabcolor(green)), ///
	 mlabel mlabposition(12)  format(%9.3f) levels(99 95) ciopts(recast(. rcap)) xlab(-0.04(0.01)0.04) xline(0, lcolor(black) lpattern("l")) yscale(line) keep(treat_post) coeflabels(treat_post = " ") ti("Logistic Regression Model") msymbol("o") note("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access")

	 
graph export "coefplot_log.png", replace
