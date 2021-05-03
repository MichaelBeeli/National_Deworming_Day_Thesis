// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Triple-Difference Results: Logistic Regression Model 


*********************************************************
** Triple Diff Log Table
*********************************************************

preserve 

keep if agegroup == "5-10"

	 eststo int_read_log_5: svy: logit three_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	 eststo int_math_log_5: svy: logit three_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	 eststo int_english_log_5: svy: logit three_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code
restore


preserve 

keep if agegroup == "11-16"

	 eststo int_read_log_11: svy: logit four_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	 eststo int_math_log_11: svy: logit four_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	 eststo int_english_log_11: svy: logit four_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore



cd "$user/Tables"

esttab int_read_log_5 int_math_log_5 int_english_log_5 int_read_log_11 int_math_log_11 int_english_log_11  using ///
"logtripleint.tex",  replace unstack gaps  nonumbers modelwidth(1) mgroups("5-7" "11-16", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English") se(%9.4f) b(%9.4f) stats(N, fmt(%9.0f) labels("Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep( _cons treat post high_cap treat_post  high_cap_treat_post high_cap_post high_cap_treat) coeflabels(treatment "Treatment" post "Post" treat_post "Treat*Post" high_cap "NDD2015" high_cap_post "NDD2015*Post" high_cap_treat "NDD2015*Treat" high_cap_treat_post "Treat*Post*NDD2015") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access") 




*********************************************************
** Coefplot (by Gender)
*********************************************************

*********************************************************
** Female

preserve

keep if agegroup == "5-10"
keep if child_female == 1 

	eststo f_triple_5_read: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code 
	// eststo order_triple_5_read : margins, dydx(treat_post) at(treat == 1 post == 1) post
	

	eststo f_triple_5_math: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
	

	// eststo order_triple_5_math : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
    eststo f_triple_5_english: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code

	// eststo order_triple_5_english : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	
restore 

preserve

keep if agegroup == "11-16"
keep if child_female == 1

	 eststo f_triple_11_read: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code 
	 
	// eststo order_triple_5_read : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	eststo f_triple_11_math: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
	

	// eststo order_triple_5_math : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
    eststo f_triple_11_english: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	// eststo order_triple_5_english : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	
restore 


*********************************************************
** Male

preserve

keep if agegroup == "5-10"
keep if child_female == 0

	eststo m_triple_5_read: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code 
	// eststo order_triple_5_read : margins, dydx(treat_post) at(treat == 1 post == 1) post
	

	eststo m_triple_5_math: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
	

	// eststo order_triple_5_math : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
    eststo m_triple_5_english: svy: logit three_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code

	// eststo order_triple_5_english : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	
restore 

preserve

keep if agegroup == "11-16"
keep if child_female == 0

	 eststo m_triple_11_read: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code 
	// eststo order_triple_5_read : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	eststo m_triple_11_math: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
	

	// eststo order_triple_5_math : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
    eststo m_triple_11_english: svy: logit four_read_code treat post high_cap high_cap_treat high_cap_post treat_post high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	// eststo order_triple_5_english : margins, dydx(treat_post) at(treat == 1 post == 1) post
	
	
restore 




cd "$user/Figures"
  
coefplot (m_triple_5_read, mcolor(ebblue) lcolor(ebblue)) || m_triple_5_math || m_triple_5_english || (m_triple_11_read, mcolor(ebblue) lcolor(ebblue)) || m_triple_11_math || m_triple_11_english|| f_triple_5_read || f_triple_5_math || f_triple_5_english || f_triple_11_read || f_triple_11_math|| f_triple_11_english, keep(high_cap_treat_post)  bycoefs coeflabels(m_read_lpm = "Males") bylabels("Boys (5-10): Reading" "Boys (5-10): Math" "Boys (5-10): English" "Boys (11-16): Reading" "Boys (11-16): Math" "Boys (11-16): English" "Girls (5-10): Reading" "Girls (5-10): Math" "Girls (5-10): English" "Girls (11-16): Reading" "Girls (11-16): Math" "Girls (11-16): English") mlabel mlabcolor(ebblue) mlabposition(12) format(%9.3f) levels(99 95) ciopts(recast(. rcap) color(ebblue ebblue))  xline(0, lcolor(cranberry) lpattern("l")) yscale(line) mcolor(ebblue) 


graph export "triplelog_coefplot.png"





