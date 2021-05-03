// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Heterogeneous Effects CoefPlot



******* Males (5-10) *******

preserve 
	
	keep if child_female == 0
	keep if child_age < 11
		
	quietly eststo my_read_lpm: svy: reg three_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo my_math_lpm: svy: reg three_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo my_english_lpm: svy: reg three_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore 


******* Males (11-16) *******

preserve 
	
	keep if child_female == 0
	keep if child_age > 10
		
	quietly eststo mo_read_lpm: svy: reg four_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo mo_math_lpm: svy: reg four_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo mo_english_lpm: svy: reg four_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore 


******* Females (5-10) *******

preserve 
	
	keep if child_female == 1
	keep if child_age < 11
	
		
	quietly eststo fy_read_lpm: svy: reg three_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo fy_math_lpm: svy: reg three_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo fy_english_lpm: svy: reg three_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore 

******* Females (11-16) *******

preserve

	keep if child_female == 1
	keep if child_age > 10

	quietly eststo fo_read_lpm: svy: reg four_read_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo fo_math_lpm: svy: reg four_math_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

	quietly eststo fo_english_lpm: svy: reg four_english_code treat post treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code

restore 


******* Boys, Girls 5-11, & Girls 12-16 Treatment Effects Graph *******
cd "$user/Figures"
  
coefplot (my_read_lpm, mcolor(ebblue) lcolor(ebblue)) || my_math_lpm || my_english_lpm || (mo_read_lpm, mcolor(ebblue) lcolor(ebblue)) || mo_math_lpm || mo_english_lpm || fy_read_lpm || fy_math_lpm || fy_english_lpm || fo_read_lpm || fo_math_lpm || fo_english_lpm, keep(treat_post)  bycoefs coeflabels(m_read_lpm = "Males") bylabels("Boys (5-10): Reading" "Boys (5-10): Math" "Boys (5-10): English" "Boys (11-16): Reading" "Boys (11-16): Math" "Boys (11-16): English" "Girls (5-10): Reading" "Girls (5-10): Math" "Girls (5-10): English" "Girls (11-16): Reading" "Girls (11-16): Math" "Girls (11-16): English") mlabel mlabcolor(ebblue) mlabposition(12) format(%9.3f) levels(99 95) ciopts(recast(. rcap) color(ebblue ebblue)) xlab(-0.04(0.01)0.04) xline(0, lcolor(cranberry) lpattern("l")) yscale(line) mcolor(ebblue) 

graph export "gender_het.png", replace 
 
 

