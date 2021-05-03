// National Deworming Day Replication Package
// Author: Michael Beeli 
// Section: Analysis
// Function: Triple-Difference Ordered Logit 



*********************************************************
** Table of Results
*********************************************************

preserve

keep if agegroup == "5-10"

	eststo order_triple_5_read: gsvy: gologit2 read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code, or 
	
	eststo order_triple_5_math: svy: gologit2 math_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code, or
	
    eststo order_triple_5_english: svy: gologit2 english_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code, or
		
restore 




preserve

keep if agegroup == "11-16"

	 eststo order_triple_11_read: svy: gologit2 read_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code, or 

	eststo order_triple_11_math: svy: gologit2 math_code treat post high_cap high_cap_treat high_cap_post treat_post  high_cap_treat_post  govt_clinic private_clinic anganwadi hh_toilet I.State_code, or
	
    eststo order_triple_11_english: svy: gologit2 english_code treat post high_cap high_cap_treat high_cap_post treat_post high_cap_treat_post govt_clinic govt_clinic private_clinic anganwadi hh_toilet I.State_code, or

	
restore 


cd "$user/tables"

esttab order_triple_5_read order_triple_5_math order_triple_5_english order_triple_11_read order_triple_11_math order_triple_11_english using ///
"ordered_triple.tex",  replace gaps  nonumbers modelwidth(1) mgroups("5-7" "11-16", pattern(1 0 0 1 0 0) span  prefix(\multicolumn{@span}{c}{) suffix(}) ///
erepeat(\cmidrule(lr){@span})) mtitles("Reading" "Math" "English" "Reading" "Math" "English")  se(%9.4f) b(%9.4f) stats(N, fmt(%9.0f) labels("Number of Observations")) nonotes starlevels(* .10 ** .05 *** .01) keep(treat_post high_cap_treat_post) coeflabels(treat_post "OR: Score > 1 (1)" high_cap_treat_post "OR: Score > 1 (2)") addnote("Note: Controls include state, presence of clinics and Anganwadis, and household toilet access") 












