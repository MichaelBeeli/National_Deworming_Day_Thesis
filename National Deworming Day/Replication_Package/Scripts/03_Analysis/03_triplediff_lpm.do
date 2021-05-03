// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Triple-Difference Results: Linear Probability Model 


*********************************************************
** Triple Diff LPM Table
*********************************************************

preserve 

keep if agegroup == "5-10"

	quietly eststo int_read_lpm_5: svy: reg three_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo int_math_lpm_5: svy: reg three_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo int_english_lpm_5: svy: reg three_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
restore


preserve 

keep if agegroup == "11-16"

	quietly eststo int_read_lpm_11: svy: reg four_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo int_math_lpm_11: svy: reg four_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo int_english_lpm_11: svy: reg four_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore


cd "$user/Tables"


esttab int_read_lpm_5 int_math_lpm_5 int_english_lpm_5 int_read_lpm_11 int_math_lpm_11 int_english_lpm_11  using ///
"tripleint.tex",  replace unstack gaps  nonumbers modelwidth(1) mgroups("5-7" "11-16", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English") se(%9.4f) b(%9.4f) ar2 stats(r2_a N, fmt(%9.3f %9.0f) labels("Adjusted R Squared" "Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep( _cons treat post high_cap treat_post  high_cap_treat_post high_cap_post high_cap_treat) coeflabels(treatment "Treatment" post "Post" treat_post "Treat*Post" high_cap "NDD2015" high_cap_post "NDD2015*Post" high_cap_treat "NDD2015*Treat" high_cap_treat_post "Treat*Post*NDD2015") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access") 



*********************************************************
** Triple Diff LPM Coefplot
*********************************************************


************************************************ 
** Male 

preserve 

keep if agegroup == "5-10"
keep if child_female == 0 

	quietly eststo m_int_read_lpm_5: svy: reg three_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo m_int_math_lpm_5: svy: reg three_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo m_int_english_lpm_5: svy: reg three_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
restore


preserve 

keep if agegroup == "11-16"
keep if child_female == 0 

	quietly eststo m_int_read_lpm_11: svy: reg four_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo m_int_math_lpm_11: svy: reg four_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo m_int_english_lpm_11: svy: reg four_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore


************************************************ 
** Female 

preserve 

keep if agegroup == "5-10"
keep if child_female == 1 

	quietly eststo f_int_read_lpm_5: svy: reg three_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo f_int_math_lpm_5: svy: reg three_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo f_int_english_lpm_5: svy: reg three_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code
restore


preserve 

keep if agegroup == "11-16"
keep if child_female == 1

	quietly eststo f_int_read_lpm_11: svy: reg four_read_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo f_int_math_lpm_11: svy: reg four_math_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo f_int_english_lpm_11: svy: reg four_english_code treat post high_cap treat_post high_cap_post high_cap_treat high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore



cd "$user/Figures"
  
coefplot (int_read_lpm_5, mcolor(ebblue) lcolor(ebblue)) || int_math_lpm_5 || int_english_lpm_5 || (int_read_lpm_11, mcolor(ebblue) lcolor(ebblue)) || int_math_lpm_11 || int_english_lpm_11, keep( treat_post high_cap_treat_post)  bycoefs coeflabels(treat_post = "Low Capacity States" high_cap_treat_post = "High Capacity States" ) bylabels("(5-10): Reading" "(5-10): Math" "(5-10): English" "(11-16): Reading" "(11-16): Math" "(11-16): English") mlabel mlabcolor(ebblue) mlabposition(12) format(%9.3f) levels(99 95) ciopts(recast(. rcap) color(ebblue ebblue)) xlab(-0.04(0.02)0.06) xline(0, lcolor(cranberry) lpattern("l")) yscale(line) mcolor(ebblue) 


graph export "triplelpm_coefplot.png", replace



